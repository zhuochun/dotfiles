require "net/http"
require "json"
require "open3"
require "timeout"
require "fileutils"

MODE_SEPARATOR = "###### "

ROLE_SYSTEM = "system"
ROLE_USER = "user"
ROLE_ASSISTANT = "assistant"

OPENAI_API = ENV["DOT_OPENAI_API"] || "openai" # azure or openai
OPENAI_KEY = ENV["DOT_OPENAI_KEY"] || ""
OPENAI_URL = ENV["DOT_OPENAI_URL"] || "https://api.openai.com/v1"

OPENAI_MODEL  = ENV["DOT_OPENAI_MODEL"] || "gpt-4o-mini"
AZURE_VERSION = ENV["DOT_AZURE_VERSION"] || "" # https://learn.microsoft.com/en-us/azure/ai-services/openai/reference

OLLAMA_URL = ENV["DOT_OLLAMA_URL"] || "http://localhost:11434/api"

def check_path(prompt_path)
  if prompt_path.empty? || !File.exist?(prompt_path)
    STDOUT << "File path not found #{prompt_path}\n"
    exit 1
  end
end

def to_next_role(role)
  role != ROLE_USER ? ROLE_USER : ROLE_ASSISTANT
end

def create_message(role, content)
  { :role => role, :content => Array(content).join("\n") }
end

def open_file(prompt_path)
  role = ROLE_SYSTEM # starts with system setup
  messages = []

  File.open(prompt_path, "r") do |file|
    content = []

    file.each_line do |line|
      line.strip!

      if line.start_with?(MODE_SEPARATOR)
        messages << create_message(role, content)

        next_role = line.split(MODE_SEPARATOR)[1].strip
        # small auto fix when multiple prompt
        if role == next_role
          # we don't start a new one, automatically continue the msg
        else
          content = [] # reset
          role = to_next_role(role)
        end
      else
        content << line unless line.empty?
      end
    end

    messages << create_message(role, content) unless content.empty?
  end

  if messages.length <= 1
    messages[0][:role] = ROLE_USER
  elsif messages[0][:role] == ROLE_SYSTEM && messages[1][:role] == ROLE_ASSISTANT
    messages[0][:role] = ROLE_USER
  end

  messages
end

def write_file(path, msgs)
  File.open(path, "w") do |file|
    msgs.each_with_index do |msg, idx|
      if idx > 0
        file.puts("")
        file.puts("#{MODE_SEPARATOR} #{msg[:role]}")
        file.puts("")
      end

      file.print(msg[:content])
    end
  end
end

def append_file(prompt_path, msgs)
  File.open(prompt_path, "a") do |file|
    msgs.each do |msg|
      file.puts("")
      file.puts("#{MODE_SEPARATOR} #{msg[:role]}")
      file.puts("")

      file.print(msg[:content])
    end
  end
end

def count_tokens(text)
  # Extract words (letters, numbers, punctuations as separate tokens)
  english_tokens = text.scan(/\w+|[[:punct:]]/)
  # Extract Chinese characters separately
  chinese_tokens = text.scan(/\p{Han}/)
  # Count total tokens
  return english_tokens.size + chinese_tokens.size
end

def post_openai(uri, auth, reqData)
  url = URI(uri)

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true unless auth.empty?
  http.read_timeout = 600 # Time in seconds

  headers = {
    "Content-Type" => "application/json"
  }.merge(auth)

  request = Net::HTTP::Post.new(url, headers)
  request.body = reqData.to_json

  http.request(request)
end

def chat(provider, data)
  uri = ""
  auth = {}

  if provider == "ollama" # https://github.com/ollama/ollama/blob/main/docs/api.md
    uri = OLLAMA_URL + "/chat"
    # disable stream
    data = data.merge({"stream" => false, "options" => {"num_ctx" => 4096}})
    # move temperature inside
    data["options"]["temperature"] = data.delete("temperature") if data["temperature"]

  elsif provider == "azure"
    uri = OPENAI_URL + uri + "/chat/completions?api-version=#{AZURE_VERSION}"
    auth["api-key"] = OPENAI_KEY

  else # assume openai compatible, https://platform.openai.com/docs/api-reference/chat/create
    uri = OPENAI_URL + "/chat/completions"
    auth["Authorization"] = "Bearer #{OPENAI_KEY}"
  end

  response = post_openai(uri, auth, data)

  if response.code != "200"
    STDERR << "Chat resp: [#{response.code}] #{response.body}\n"
    STDERR << "Chat input: [#{uri}] #{data}\n"
    exit 1
  end

  begin
    JSON.parse(response.body)
  rescue JSON::ParserError => e
    STDERR << "Resp parsing error: #{e.message}"
    STDERR << "Chat resp: [#{response.code}] #{response.body}\n"
    STDERR << "Chat input: [#{uri}] #{data}\n"

    {}
  end
end

def chat_resp(messages, opts = {})
  data = {
    "model" => OPENAI_MODEL,
    "messages" => messages
  }.merge(opts)

  provider, model = data["model"].split(":", 2)
  if model.nil? # support gpt-4o or ollama:qwen2.5:3b
    provider = OPENAI_API
  else
    data["model"] = model
  end

  result = chat(provider, data)

  begin
    if provider == "ollama"
      result.dig("message", "content")
    else # openai compatible
      result.dig("choices", 0, "message", "content")
    end
  rescue StandardError => e
    STDERR << "Resp format error: #{e.message}"
    STDERR << "Chat result: #{result}\n"

    ""
  end
end


def json_response(payload)
  JSON.generate(payload)
rescue StandardError => e
  JSON.generate({ "ok" => false, "error" => "json_encode_error: #{e.message}" })
end

def resolve_path(path)
  File.expand_path(path, Dir.pwd)
end

def tool_read_file(args)
  path = args["path"]
  return json_response({ "ok" => false, "error" => "missing path" }) if path.nil? || path.empty?

  full_path = resolve_path(path)
  return json_response({ "ok" => false, "error" => "file not found: #{full_path}" }) unless File.file?(full_path)

  content = File.read(full_path)
  json_response({ "ok" => true, "path" => full_path, "content" => content })
rescue StandardError => e
  json_response({ "ok" => false, "error" => e.message })
end

def tool_write_file(args)
  path = args["path"]
  content = args["content"].to_s
  return json_response({ "ok" => false, "error" => "missing path" }) if path.nil? || path.empty?

  full_path = resolve_path(path)
  FileUtils.mkdir_p(File.dirname(full_path))
  File.write(full_path, content)

  json_response({ "ok" => true, "path" => full_path, "bytes" => content.bytesize })
rescue StandardError => e
  json_response({ "ok" => false, "error" => e.message })
end

def tool_bash(args)
  command = args["command"]
  timeout_s = (args["timeout_s"] || 30).to_i
  return json_response({ "ok" => false, "error" => "missing command" }) if command.nil? || command.empty?

  stdout = ""
  stderr = ""
  status = nil

  begin
    Timeout.timeout(timeout_s) do
      stdout, stderr, status = Open3.capture3("bash", "-lc", command)
    end
  rescue Timeout::Error
    return json_response({ "ok" => false, "error" => "command timeout after #{timeout_s}s" })
  end

  json_response({
    "ok" => status.success?,
    "exit_code" => status.exitstatus,
    "stdout" => stdout,
    "stderr" => stderr
  })
rescue StandardError => e
  json_response({ "ok" => false, "error" => e.message })
end

def chat_message(messages, opts = {}, tools = nil)
  data = {
    "model" => OPENAI_MODEL,
    "messages" => messages
  }.merge(opts)
  data["tools"] = tools unless tools.nil?

  provider, model = data["model"].split(":", 2)
  if model.nil?
    provider = OPENAI_API
  else
    data["model"] = model
  end

  result = chat(provider, data)

  if provider == "ollama"
    msg = result["message"] || {}
    {
      "role" => msg["role"] || "assistant",
      "content" => msg["content"].to_s,
      "tool_calls" => msg["tool_calls"] || []
    }
  else
    result.dig("choices", 0, "message") || {}
  end
end

def run_agent(msgs, model_opts)
  tools = [
    {
      "type" => "function",
      "function" => {
        "name" => "bash",
        "description" => "Run a bash command in the current working directory",
        "parameters" => {
          "type" => "object",
          "properties" => {
            "command" => { "type" => "string" },
            "timeout_s" => { "type" => "integer", "minimum" => 1, "maximum" => 120 }
          },
          "required" => ["command"]
        }
      }
    },
    {
      "type" => "function",
      "function" => {
        "name" => "read_file",
        "description" => "Read a text file from disk",
        "parameters" => {
          "type" => "object",
          "properties" => {
            "path" => { "type" => "string" }
          },
          "required" => ["path"]
        }
      }
    },
    {
      "type" => "function",
      "function" => {
        "name" => "write_file",
        "description" => "Write text content to a file, replacing existing content",
        "parameters" => {
          "type" => "object",
          "properties" => {
            "path" => { "type" => "string" },
            "content" => { "type" => "string" }
          },
          "required" => ["path", "content"]
        }
      }
    }
  ]

  max_turns = 8
  turn = 0
  assistant_content = ""

  while turn < max_turns
    turn += 1
    msg = chat_message(msgs, model_opts, tools)
    tool_calls = msg["tool_calls"] || []

    assistant_msg = {
      :role => ROLE_ASSISTANT,
      :content => msg["content"].to_s
    }
    assistant_msg[:tool_calls] = tool_calls unless tool_calls.empty?
    msgs << assistant_msg

    if tool_calls.empty?
      assistant_content = msg["content"].to_s
      break
    end

    tool_calls.each do |tc|
      fn = tc.dig("function", "name").to_s
      args_str = tc.dig("function", "arguments").to_s
      args = JSON.parse(args_str.empty? ? "{}" : args_str) rescue {}

      result = case fn
               when "bash"
                 tool_bash(args)
               when "read_file"
                 tool_read_file(args)
               when "write_file"
                 tool_write_file(args)
               else
                 json_response({ "ok" => false, "error" => "unknown tool: #{fn}" })
               end

      msgs << {
        :role => "tool",
        :tool_call_id => tc["id"],
        :content => result
      }
    end
  end

  assistant_content
end

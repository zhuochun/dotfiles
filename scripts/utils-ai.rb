require "net/http"
require "json"

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

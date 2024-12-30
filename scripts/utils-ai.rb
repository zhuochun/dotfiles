require "net/http"
require "json"

MODE_SEPARATOR = "###### "

ROLE_SYSTEM = "system"
ROLE_USER = "user"
ROLE_ASSISTANT = "assistant"

OPENAI_API = ENV["DOT_OPENAI_API"] || "openai" # azure or openai
OPENAI_KEY = ENV["DOT_OPENAI_KEY"] || ""
OPENAI_URL = ENV["DOT_OPENAI_URL"] || "https://api.openai.com/v1"
OLLAMA_URL = ENV["DOT_OLLAMA_URL"] || "http://localhost:11434/api"
AZURE_VERSION = ENV["DOT_AZURE_VERSION"] || "" # https://learn.microsoft.com/en-us/azure/ai-services/openai/reference

def check_ai_env
  if OPENAI_KEY.empty?
    STDOUT << "Remember to set env DOT_OPENAI_KEY\n"
    exit 9
  end
end

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
      file.puts("\n#{MODE_SEPARATOR} #{msg[:role]}") if idx > 0
      file.puts("\n#{msg[:content]}")
    end
  end
end

def append_file(prompt_path, msgs)
  File.open(prompt_path, "a") do |file|
    msgs.each do |msg|
      file.puts("\n#{MODE_SEPARATOR} #{msg[:role]}")
      file.puts("\n#{msg[:content]}")
    end
  end
end

def post_openai(uri, auth, reqData)
  url = URI(uri)
  url.query = "api-version=#{AZURE_VERSION}" if OPENAI_API == "azure"

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true unless auth.nil?
  http.read_timeout = 600 # Time in seconds

  headers = { "Content-Type" => "application/json" }

  if OPENAI_API == "openai"
    headers["Authorization"] = "Bearer #{auth}" unless auth.nil?
  else
    headers["api-key"] = auth unless auth.nil?
  end

  request = Net::HTTP::Post.new(url, headers)
  request.body = reqData.to_json

  return http.request(request)
end

def chat(data) # https://platform.openai.com/docs/api-reference/chat/create
  uri = OPENAI_URL + "/chat/completions"
  response = post_openai(uri, OPENAI_KEY, data)

  if response.code != "200"
    STDERR << "Chat error: #{response.body}\n"
    exit 1
  end

  result = JSON.parse(response.body)
end

def chat_resp(messages, opts = {})
  data = {
    "model" => "gpt-4o-mini",
    "messages" => messages
  }.merge(opts)

  result = chat(data)
  result["choices"][0]["message"]["content"]
end

def embedding(txts, opts = {})
  data = {
    "model" => "text-embedding-3-small",
    "input" => txts
  }.merge(opts)

  uri = OPENAI_URL + "/embeddings"
  response = post_openai(uri, OPENAI_KEY, data)

  if response.code != "200"
    STDERR << "Embedding error: #{response.body}\n"
    exit 1
  end

  result = JSON.parse(response.body)
  result["data"][0]["embedding"]
end

def embedding_ollama(txts, opts = {})
  data = {
    "model" => "nomic-embed-text",
    "prompt" => txts
  }.merge(opts)

  uri = OLLAMA_URL + "/embeddings"
  response = post_openai(uri, nil, data)

  if response.code != "200"
    STDERR << "Embedding error: #{response.body}\n"
    exit 1
  end

  result = JSON.parse(response.body)
  result["embedding"]
end

def cosine_similarity(array1, array2)
  dot_product = 0.0
  norm_a = 0.0
  norm_b = 0.0

  array1.each_with_index do |value1, index|
    value2 = array2[index]

    dot_product += value1 * value2
    norm_a += value1 * value1
    norm_b += value2 * value2
  end

  norm_a = Math.sqrt(norm_a)
  norm_b = Math.sqrt(norm_b)

  cosine_similarity = dot_product / (norm_a * norm_b)
end

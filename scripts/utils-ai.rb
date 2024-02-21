require "net/http"
require "json"

MODE_SEPARATOR = "###### "
ROLE_SYSTEM = "system"
ROLE_USER = "user"
ROLE_ASSISTANT = "assistant"
NEXT_ROLE = ->(role) { role != ROLE_USER ? ROLE_USER : ROLE_ASSISTANT }

def check_path(prompt_path)
  if prompt_path.empty? || !File.exist?(prompt_path)
    STDOUT << "File path not found #{prompt_path}\n"
    exit 1
  end
end

def open_file(prompt_path)
  role = ROLE_SYSTEM # starts with system setup
  messages = []

  File.open(prompt_path, "r") do |file|
    content = []

    file.each_line do |line|
      line.strip!

      if line.start_with?(MODE_SEPARATOR)
        messages << { :role => role, :content => content.join("\n") }

        next_role = line.split(MODE_SEPARATOR)[1].strip
        # small auto fix when multiple prompt
        if role == next_role
          # we don't start a new one, automatically continue the msg
        else
          content = [] # reset
          role = NEXT_ROLE.call(role)
        end
      else
        content << line unless line.empty?
      end
    end

    messages << { :role => role, :content => content.join("\n") } unless content.empty?
  end

  if messages.length <= 1
    messages[0][:role] = ROLE_USER
  elsif messages[0][:role] == ROLE_SYSTEM && messages[1][:role] == ROLE_ASSISTANT
    messages[0][:role] = ROLE_USER
  end

  STDOUT << "Loaded: #{prompt_path}. Messages: #{messages.length}\n"
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

def post_openai(uri, reqData)
  url = URI(uri)

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.read_timeout = 600 # Time in seconds

  headers = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{OPENAI_KEY}"
  }

  request = Net::HTTP::Post.new(url, headers)
  request.body = reqData.to_json

  return http.request(request)
end

def chat(messages, opts = {})
  data = {
    "model" => "gpt-3.5-turbo-16k",
    "messages" => messages
  }.merge(opts)

  uri = "https://api.openai.com/v1/chat/completions"

  response = post_openai(uri, data)

  if response.code != "200"
    STDOUT << "Chat error: #{response}\n"
    exit 1
  end

  result = JSON.parse(response.body)
  STDOUT << "Chat usage: #{result["usage"]}, model: #{data["model"]}\n"

  result["choices"][0]["message"]["content"]
end

def embedding(txts, opts = {})
  data = {
    "model" => "text-embedding-ada-002",
    "input" => txts
  }.merge(opts)

  uri = "https://api.openai.com/v1/embeddings"

  response = post_openai(request)

  if response.code != "200"
    STDOUT << "Embedding error: #{response}\n"
    exit 1
  end

  result = JSON.parse(response.body)
  STDOUT << "Chat usage: #{result["usage"]}, model: #{data["model"]}\n"

  result["data"][0]["embedding"]
end

def speech(msg, opts = {})
  data = {
    "model" => "tts-1",
    "voice" => "echo",
    "input" => msg
  }.merge(opts)

  uri = "https://api.openai.com/v1/audio/speech"

  if response.code != "200"
    STDOUT << "Speech error: #{response}\n"
    exit 1
  end

  response.body # stream of response body
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

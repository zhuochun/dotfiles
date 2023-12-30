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

def chat(messages, opts = {})
  url = URI("https://api.openai.com/v1/chat/completions")
  headers = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{OPENAI_KEY}"
  }

  data = {
    "model" => "gpt-3.5-turbo-16k",
    "messages" => messages
  }.merge(opts)

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.read_timeout = 600 # Time in seconds

  request = Net::HTTP::Post.new(url, headers)
  request.body = data.to_json

  response = http.request(request)

  if response.code != "200"
    STDOUT << "Chat error: #{response}\n"
    exit 1
  end

  result = JSON.parse(response.body)
  STDOUT << "Chat usage: #{result["usage"]}, model: #{data[:model]}\n"

  result["choices"][0]["message"]["content"]
end

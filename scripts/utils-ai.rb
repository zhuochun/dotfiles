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

def append_file(prompt_path, role, msg)
  File.open(prompt_path, "a") do |file|
    file.puts("\n#{MODE_SEPARATOR} #{role}")
    file.puts("\n#{msg}")
  end
end

def chat(messages)
  url = URI("https://api.openai.com/v1/chat/completions")
  headers = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{OPENAI_KEY}"
  }

  data = {
    "model" => "gpt-3.5-turbo-16k",
    "messages" => messages
  }

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Post.new(url, headers)
  request.body = data.to_json

  response = http.request(request)

  if response.code != "200"
    STDOUT << "Chat error: #{response}\n"
    exit 1
  end

  result = JSON.parse(response.body)
  result["choices"][0]["message"]["content"]
end

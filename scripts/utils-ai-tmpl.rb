require "erb"

class PromptTemplate
  attr_reader :filename

  def initialize(f, raw = "")
    @filename = f
    @raw_text = raw || File.read(f)
    @erb_tmpl = ERB.new(@raw_text)
    @end_text = nil

    STDOUT << "Init #{self}\n"
  end

  def +(other) # pass the end_text message to the other as SYSTEM
    @end_text = @erb_tmpl.result(binding) if @end_text.nil?

    other.preload(self, { :role => ROLE_SYSTEM, :content => @end_text }) unless other.nil?
    other
  end

  def -(other) # pass the end_text to the other as USER
    @end_text = @erb_tmpl.result(binding) if @end_text.nil?

    other.append(self, { :role => ROLE_USER, :content => @end_text }) unless other.nil?
    other
  end

  def >>(other) # alias to -
    self.-(other)
  end

  def append(src, msg) # receive one message from another
    STDOUT << "Append TEMPLATE context #{src} -> #{self}\n"

    @end_text = @erb_tmpl.result(binding)

    self
  end

  def save_file
    # do nothing
  end

  def to_s
    "PromptTemplate(#{@filename})"
  end
end

T_CODE = PromptTemplate.new("T_CODE", """
Guidelines:
- Respond in clean code, be concise and human readable.
- Write simple and essential comments only if needed.
- No text expanation required.

Filename: <%= File.basename(other&.filename || src&.filename) %>
""")
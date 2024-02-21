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
You are an assistent helping in programming.

Guidelines:
- Respond in clean code, be concise and human readable.
- Write simple and essential comments only if needed.
- No text expanation required.

Filename: <%= File.basename(other&.filename || src&.filename) %>
""")

T_SUMMARY = PromptTemplate.new("T_SUMMARY", """
You are an assistant helping summarize a document. Use this format, replacing text in brackets with the result. Do not include the brackets in the output:

Summary in [Identified language of the document]:

[One-paragaph summary of the document using the identified language.].
""")

T_AI = PromptTemplate.new("T_ACTION_ITEM", """
You are an assistant helping find action items inside a document. An action item is an extracted task or to-do found inside of an unstructured document. Use this format, replacing text in brackets with the result. Do not include the brackets in the output:

List of action items in [Identified language of the document]:

[List of action items in the identified language, in markdown format. Prefix each line with `- []` to make it a checkbox.]
""")

T_FILL = PromptTemplate.new("T_FILL_BLANK", """
You are an assistant helping fill the blanks indicated with delimiter `???`.

Follow the context, make reasonable assumptions, use the identified language of the document and then fill the blanks.
""")
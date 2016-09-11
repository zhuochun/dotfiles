#!/usr/bin/env ruby
# encoding: utf-8

require 'time'
require 'json'

# Generate a go struct from JSON file
#
# Usage:
#
#   ./go-json.rb file.json structName
#

def parse_json(text)
  JSON.parse(text)
rescue JSON::ParserError => e
  $stdout << "Invalid JSON file content #{e}\n"
  exit(1)
end

def parse_time(time_str)
  %i(httpdate iso8601 rfc2822 rfc822).each do |m|
    begin
      return Time.send(m, time_str)
    rescue ArgumentError
    end
  end
  nil
end

class StructWriter
  attr_reader :name, :fields, :content, :root, :type, :structs

  def initialize(name, content, root: false)
    @name = name
    @content = content
    @content = content.first if root && content.is_a?(Array)
    @root = root
    @fields = [] # this struct fields
    @structs = [] # inner structs, for nested json objects
  end

  def camelcase(name, lower = false)
    name = name.gsub(/([A-Z])/, "_\\1") # convert snakeCase
    str = name.split('_')
      .map(&:capitalize)
      .map { |w| w == 'Id' ? "ID" : w }
      .map { |w| w == 'Ids' ? "IDs" : w }
      .join
    str[0] = str[0].downcase if lower
    str
  end

  def titlelize(str)
    name.gsub(/([A-Z][a-z])/, ' \1').strip.downcase
  end

  def parse_struct(k, data)
    field = camelcase(k)
    attrs = ',omitempty' if k == 'id'

    if data.is_a?(Array)
      field = field.chop # assume Array field has suffix "s"
      prefix = "[]"
      data = data.first
    end

    type = data.is_a?(Hash) ? to_struct(field, data) : to_gotype(data)
    fields << "#{camelcase(k)} #{prefix}#{type} `json:\"#{k}#{attrs}\"`"
  end

  def to_struct(field, data)
    struct_name = "#{name}#{field}"
    structs << StructWriter.new(struct_name, data)
    "*#{struct_name}"
  end

  def to_gotype(data)
    case data
    when Integer, Fixnum then 'int64'
    when Float then 'float64'
    when TrueClass, FalseClass then 'bool'
    when String then data =~ /\d{4}/ && parse_time(data) ? 'time.Time' : 'string'
    end
  end

  def write
    if @content.is_a?(Hash)
      @content.each { |k, v| parse_struct(k, v) }
    else
      $stdout << "Invalid data: #{@content}\n"
      exit(1)
    end

    <<-EOS
// #{name} defines a struct for #{titlelize(name)}
type #{name} struct {
    #{fields.join("\n    ")}
}

#{structs.map(&:write).join("")}
    EOS
  end
end

# ARGV Logic
if ARGV.length < 2
  $stdout << "Usage: ./go-json.rb file.json StructName\n"
  exit(1)
end

file = ARGV[0]
unless File.exist?(file)
  $stdout << "File #{file} not found\n"
  exit(1)
end

content = parse_json(File.read(file))
writer = StructWriter.new(ARGV[1], content, root: true)
$stdout << writer.write

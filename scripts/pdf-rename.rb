#!/usr/bin/env ruby
# encoding: utf-8

# Try to rename by read the PDF content
#
#   ./pdf-rename.rb file.pdf -Y
#
#   find ~/Downloads | ag "\d+.pdf" H | head -n 2 | YES=1 xargs -n 1 ./pdf-rename.rb
#
# Dependency: gem install pdf-reader
#
require "pdf-reader"
require "colorize"

def agree_or_alternative(candidate, lines)
  return candidate if ENV["YES"].to_s == "1"

  if candidate.nil?
    STDOUT << "Enter (line,line): ".yellow
  else
    STDOUT << "Use \"#{candidate.red.bold}\"?\n"
    STDOUT << "Yes or Enter (line,line): ".yellow
  end

  input = STDIN.gets.chomp
  return candidate if input.empty? || input.upcase == "Y"
  return "" if input.upcase == "N" # explict reject

  if input =~ /^\d+$/
    lines[input.to_i]
  elsif input =~ /^\d+(,\d+)+$/
    input.split(",").map(&:to_i).map do |i|
      lines[i]
    end.join(" ")
  else
    input
  end
end

if ARGV.length != 1
  STDERR << "Usage: ./pdf-rename.rb filename.pdf\n"
  exit 1
end

r = begin
      PDF::Reader.new(ARGV[0])
    rescue Exception => e
      STDERR << "Error: Invalid Pdf, #{e}"
      exit 1
    end

if r.page_count < 1
  STDERR << "Error: No page found\n"
  exit 3
end

lines = begin
          r.pages[0].text
            .split("\n")
            .map { |line| line.strip.gsub(/\s+/, " ") }
            .select { |line| !line.empty? }
            .take(10)
        rescue Exception => e
          STDERR << "Error: Text not found, #{e}"
          exit 1
        end

if lines.empty?
  STDERR << "Error: Empty first page\n"
  exit 3
end

STDOUT << "Lines:\n".blue
lines.each_with_index do |line, idx|
  STDOUT << "  [#{idx}] #{line}\n"
end

# simple guess by looking at the first 10 lines:
#
# - Use the first sentence with >= 3 words, and start with a capitalized char
# - Otherwise, let the user to choose from line, or enter a new name
#
candidate_idx = lines.find_index do |line|
  words = line.split(" ")
  return false if words.length < 3

  word = words[0].gsub(/[^a-zA-Z]/, "")
  word[0] == word[0].upcase
end

candidate = lines[candidate_idx]
# add next line if the line end with any of this
if ["and", "for", ","].any? { |w| candidate.downcase.end_with?(w) }
  candidate << " " << lines[candidate_idx+1]
end

candidate = agree_or_alternative(candidate, lines)
if candidate.empty?
  STDERR << "Error: No title found\n"
  exit 4
end

path, filename = File.split(ARGV[0])

slug = candidate.downcase.gsub(/[^\w]/, '-').gsub(/-+/, '-').gsub(/^-|-$/, '')
new_file = File.join(path, "#{slug}.pdf")

File.rename(ARGV[0], new_file)
STDOUT << "Renamed: #{ARGV[0].blue} -> #{new_file.green}\n"

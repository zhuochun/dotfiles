#!/usr/bin/env ruby
# encoding: utf-8

# Try to rename by read the PDF content
#
#   ~/dotfiles/scripts/pdf-rename.rb file.pdf
#
#   find ~/Downloads | ag "\d+.pdf" | head -n 2 | YES=1 xargs -n 1 ~/dotfiles/scripts/pdf-rename.rb
#
# Dependency: gem install pdf-reader
#
require "pdf-reader"
require "colorize"
require "readline"
require 'set'

def has_conj?(l1, l2)
  l1, l2 = l1.downcase, l2.downcase

  ["and", "for", "the", "to", "on", "of", ",", "&"].any? do |w|
    l1.end_with?(" " + w) || l2.start_with?(w + " ")
  end
end

def slug(str)
  str.downcase.gsub(/[^\w]/, '-').gsub(/-+/, '-').gsub(/^-|-$/, '')
end

def agree_or_alternative(candidate, lines)
  return candidate if ENV["YES"].to_s == "1"

  # Push lines to history, and add words to completion
  completion_words = lines.flat_map do |line|
    Readline::HISTORY << line
    line.downcase.split(" ")
  end

  completion_words = Set.new(completion_words).to_a

  Readline.completion_proc = Proc.new do |str|
    completion_words.select { |w| w if w.start_with?(str) }
  end

  hint = "Enter: (LINE,LINE) "

  unless candidate.nil?
    Readline::HISTORY << candidate
    STDOUT << "Use \"#{slug(candidate).yellow.bold}\"?\n"
    hint = "Enter: (Y/N | LINE,LINE) "
  end

  input = Readline.readline(hint, true).chomp
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

stty_save = %x`stty -g`.chomp
# Trap Ctrl+C
trap("INT") { system("stty", stty_save); exit }

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
        rescue Exception => e
          STDERR << "Error: Text not found, #{e}"
          exit 1
        end

if lines.empty?
  STDERR << "Error: Empty first page\n"
  exit 3
end

# Make a simple guess by looking at the first 10 lines:
#
# - Use the first sentence with >= 3 words, and start with a capitalized char
# - Otherwise, let the user to choose from line, or enter a new name
#
lines = lines.take(10)

candidate_idx = lines.find_index do |line|
  words = line.split(" ")
  next false if words.length < 3

  word = words[0].gsub(/[^a-zA-Z]/, "")
  next false if word.empty? # nums (e.g. year)

  word[0] == word[0].upcase
end

candidate = candidate_idx.nil? ? "" : lines[candidate_idx].dup

# Merge the next line if the line end with connect words
unless candidate_idx.nil?
  next_line = lines[candidate_idx+1]

  if !next_line.nil? && has_conj?(candidate, next_line)
    candidate << " " << next_line
  end
end

STDOUT << "Lines:\n"
lines.each_with_index do |line, idx|
  if candidate.include?(line) && (idx == candidate_idx || idx-1 == candidate_idx)
    STDOUT << "  [#{idx}] #{line.bold}\n".red
  else
    STDOUT << "  [#{idx}] #{line}\n"
  end
end

candidate = agree_or_alternative(candidate, lines)
if candidate.empty?
  STDERR << "Error: No title found\n"
  exit 4
end

path, filename = File.split(ARGV[0])
new_file = File.join(path, "#{slug(candidate)}.pdf")

File.rename(ARGV[0], new_file)
STDOUT << "Renamed: #{ARGV[0].blue} -> #{new_file.green}\n"

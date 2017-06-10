#!/usr/bin/env ruby
require 'net/http'
require 'json'

if ARGV.length < 1
  $stdout << "Usage: ./emoji-replace.rb \"some text\"\n"
  exit(1)
end

begin
  uri = URI('https://cdn.rawgit.com/notwaldorf/emoji-translate/master/extension/emojis.json')
  resp = Net::HTTP.get_response(uri)
  emoji = JSON.parse(resp.body)

  tags = Hash.new { |hash, key| hash[key] = [] }
  emoji.each do |k, e|
    next if e.is_a?(Array) || e['char'].nil? || e['char'].empty?
    tags[k] << e['char']
    e['keywords'].each { |kw| tags[kw] << e['char'] }
  end

  words = ARGV.first.split.map do |w|
    matches = tags[w]
    next matches.sample unless matches.empty?

    # remove a char from the end of word, e.g. punctuation
    matches = tags[w.chop]
    next "#{matches.sample}#{w[-1]}" unless matches.empty?

    # remove 2 chars from the end of word, punctuation + plural
    if w.length > 2
      matches = tags[w[0...-2]]
      next "#{matches.sample}#{w[-2..-1]}" unless matches.empty?
    end

    # remove 3 chars from the end of word, punctuation + past
    if w.length > 3
      matches = tags[w[0...-3]]
      next "#{matches.sample}#{w[-3..-1]}" unless matches.empty?
    end

    w # oh no, no match
  end

  $stdout << words.join(' ') << "\n"
rescue Exception => e
  $stdout << "ERROR: #{e}\n"
end

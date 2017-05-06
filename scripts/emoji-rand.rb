#!/usr/bin/env ruby
require 'net/http'
require 'json'

begin
  uri = URI('https://cdn.rawgit.com/github/gemoji/master/db/emoji.json')
  resp = Net::HTTP.get_response(uri)
  emoji = JSON.parse(resp.body)

  num = [ARGV.first.to_i, 1].max
  $stdout << emoji.map do |i|
    i['emoji'] if i['category'] != 'Flags'
  end.compact.sample(num).join(' ') << "\n"
rescue Exception => e
  $stdout << "ERROR: #{e}\n"
end

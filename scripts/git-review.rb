#!/usr/bin/env ruby
# encoding: utf-8

# Check who are the reviewers

if ARGV.length != 1
  STDERR << "Usage: ./git-review.rb directory\n"
  exit 1
end

dir = ARGV[0]

commits = `git log #{dir}`

reviewby = commits.split("\n").select do |line|
  line =~ /Reviewed By:/ && line.split(", ").length < 5
end.map do |line|
  line[16..-1].split(", ").map(&:strip).reject { |n| n.start_with?("#") }
end

# count by review by group
STDOUT << "= {Reviewed By} Group Counts\n"

count = Hash.new(0)
reviewby.each { |line| count[line.sort.join(",")] += 1 }

inverted = Hash.new { |h, k| h[k] = [] }
count.each { |key, val| inverted[val] << key }

inverted.keys.sort.reverse_each do |c|
  inverted[c].each do |r|
    STDOUT << "#{c.to_s.ljust(5)}: #{r}\n"
  end
end

STDOUT << "\n\n"

# count by individual reviewers
STDOUT << "= {Reviewed By} Individual Counts\n"

count2 = Hash.new(0)
reviewby.each do |line|
  line.each { |n| n !~ /^O\d+/ && count2[n] += 1 }
end

inverted2 = Hash.new { |h, k| h[k] = [] }
count2.each { |key, val| inverted2[val] << key }

inverted2.keys.sort.reverse_each do |c|
  inverted2[c].each do |r|
    STDOUT << "#{c.to_s.ljust(5)}: #{r}\n"
  end
end

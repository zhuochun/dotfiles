#!/usr/bin/env ruby
# encoding: utf-8

# Dependency: https://github.com/guard/listen - `gem install listen`
#
# Trigger in the directory, to listen on changes.
#
# alias wgo="~/dotfiles/scripts/go-test.rb"
#
require "logger"
require "listen"

LOG = Logger.new(STDOUT)
LOG.level = Logger::INFO

go_path_src = File.join(ENV["GOPATH"], "src", "")

LOG.info("Listening #{Dir.pwd}")

listener = Listen.to(Dir.pwd, only: /\.go$/, latency: 1) do |modified, added, removed|
  unique_paths = {}

  [modified, added, removed].each do |group|
    group.each { |file| unique_paths[File.dirname(file)] = true }
  end

  unique_paths.keys.each do |path|
    LOG.info("Detected changes in #{path}")

    output = IO.popen("go test #{path.gsub(go_path_src, "")}/... -v")

    LOG.info("\n#{output.readlines.join("")}")
  end
end

listener.start

sleep # zZZZ

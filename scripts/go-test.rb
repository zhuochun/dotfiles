#!/usr/bin/env ruby
# encoding: utf-8

# Run `go test` automatically after file changes
#
# alias wgo="~/dotfiles/scripts/go-test.rb"
#
# Dependency:
#
# - https://github.com/guard/listen
#   gem install listen
# - https://github.com/fazibear/colorize
#   gem install colorize
#
require "logger"
require "listen"
require "colorize"

LOG = Logger.new(STDOUT)
LOG.level = Logger::INFO
LOG.formatter = proc { |severity, datetime, progname, msg| "#{datetime}: #{msg}\n" }

go_path_src = File.join(ENV["GOPATH"], "src", "")
LOG.info("GOPATH: #{ENV["GOPATH"].bold}".blue)

def go_test(relative_path, options = "")
    output = IO.popen("go test #{relative_path}/... #{options}")
    output_lines = output.readlines.map do |line|
      case line
      when /Error Trace:/
        line.bold.cyan
      when /Error:/
        line.red
      when /FAIL/
        line.light_yellow.on_red
      when /PASS:/
        line.green
      when /RUN/
        line.light_cyan
      else
        line
      end
    end.join("")

    LOG.info("\n#{output_lines}")
end

listener = Listen.to(Dir.pwd, only: /\.go$/, latency: 1) do |modified, added, removed|
  unique_paths = {}

  [modified, added, removed].each do |group|
    group.each { |file| unique_paths[File.dirname(file)] = true }
  end

  unique_paths.keys.each do |path|
    relative_path = path.gsub(go_path_src, "")
    LOG.info("Detected changes in #{relative_path.bold}".cyan)

    go_test(relative_path, "-v")
  end
end

listener.start

LOG.info("Listening: #{Dir.pwd.bold}".blue)
# Initial run on whole listen path
go_test(Dir.pwd.gsub(go_path_src, ""))

sleep # zZZZ

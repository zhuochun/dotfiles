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
# - https://github.com/tonsky/AnyBar (optional)
#   brew cask install anybar
#
require "logger"
require "socket"
require "listen"
require "colorize"

LOG = Logger.new(STDOUT)
LOG.level = Logger::INFO
LOG.formatter = proc { |severity, datetime, progname, msg| "#{datetime}: #{msg}\n" }

go_path_src = File.join(ENV["GOPATH"], "src", "")
LOG.info("GOPATH: #{ENV["GOPATH"].bold}".blue)

def anybar_notify(color)
  any_bar = UDPSocket.new
  any_bar.connect "localhost", 1738
  any_bar.send color, 0
  any_bar.close
end

def go_test(relative_path, options = "")
  anybar_notify("yellow")
  output = IO.popen("go test #{relative_path}/... #{options}")

  succeed = true
  output_lines = output.readlines.map do |line|
    case line
    when /Error Trace:/
      line.bold.cyan
    when /Error:/, /panic:/, /FAIL:/
      line.red
    when /false/ # build failed
      line.light_yellow.on_red
      succeed = false
    when /^FAIL/ # the final FAIL
      line.light_yellow.on_red
      succeed = false
    when /PASS:/
      line.green
    when /RUN/
      line.light_cyan
    else
      line
    end
  end.join("")
  anybar_notify(succeed ? "green" : "red")

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

at_exit do
  anybar_notify("white")
end

sleep # zZZZ

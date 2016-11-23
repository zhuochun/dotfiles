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

GO_PATH_SRC = File.join(ENV["GOPATH"], "src", "")
LOG.info("GOPATH: #{ENV["GOPATH"].bold}".blue)

PROJECT_ROOT = Dir.pwd.gsub(GO_PATH_SRC, "")
LOG.info("Listening: #{PROJECT_ROOT.bold}".blue)

# Record the last changed directory
last_dir = ""
# Cache all the packages
cached_packages = {}

def anybar_notify(color)
  any_bar = UDPSocket.new
  any_bar.connect "localhost", 1738
  any_bar.send color, 0
  any_bar.close
end

def cache_packages(pkgs)
  Dir.glob("**/*_test.go") do |file|
    dir = File.dirname(file)
    pkg = File.split(dir).last

    pkgs[pkg] = dir
  end
end

def lookup_package(pkgs, name)
  return nil if name.nil? || name.empty?

  found = pkgs.find do |pkg, dir|
    pkg == name || pkg.start_with?(name)
  end

  if found
    LOG.info "Lookup package: #{name.bold}, found: #{found[1].to_s.bold}".cyan
    found[1]
  else
    LOG.info "Lookup package: #{name.bold}, pkg not found".cyan
    nil
  end
end

def go_test(path, options = "")
  anybar_notify("yellow")

  cmd = "go test #{path} #{options}".strip
  LOG.info("Running: #{cmd.bold}".blue)

  test_passed = true
  output_lines = []
  IO.popen(cmd) do |io|
    while line = io.gets
      # shorten and highlight path in line
      line = line.gsub(File.join(GO_PATH_SRC, PROJECT_ROOT), '.'.yellow)
      line = line.gsub(File.join(GO_PATH_SRC, File.split(PROJECT_ROOT)[0]), '..'.yellow)
      # shorten project path
      line = line.gsub(PROJECT_ROOT, '.'.yellow)
      line = line.gsub(File.split(PROJECT_ROOT)[0], '..'.yellow)
      # replace head indication
      line = line.gsub(/^ok\b/, 'ok'.green.bold)
      line = line.gsub(/^FAIL\b/, 'FAIL'.light_yellow.on_red.bold)
      # colorize
      line = case line
             when /Error Trace:/, /Error:/, /panic:/, /FAIL:/
               test_passed = false
               line.red
             when /RUN/
               line.light_cyan
             when /PASS:/
               line.green
             when /coverage: (\d+.\d+)\%/
               cov = $1.to_f
               word = "coverage: #{cov}\%".bold
               word = if cov < 60.0 then word.red
                      elsif cov < 90.0 then word.yellow
                      else word.green end
               line.gsub(/coverage: \d+.\d+\%/, word)
             else
               line
             end
      # collect all the output lines
      output_lines << line
    end
  end
  LOG.info("\n#{output_lines.join}")

  if $?.success? && test_passed
    anybar_notify("green")
  else
    anybar_notify(test_passed ? "exclamation" : "red") # build fail, or test fail
  end
end

listener = Listen.to(Dir.pwd, only: /\.go$/) do |modified, added, removed|
  unique_paths = {}

  [modified, added, removed].each do |group|
    group.each { |file| unique_paths[File.dirname(file)] = true }
  end

  print "\n" # perfectionism  ┬─┬ ノ( ^_^ノ )

  unique_paths.keys.each do |path|
    relative_path = path.gsub(GO_PATH_SRC, "")
    LOG.info("Detected changes in #{relative_path.gsub(PROJECT_ROOT, '.').bold}".cyan)

    last_dir = relative_path
    go_test(File.join(relative_path, "..."), "-v")
  end

  print "> ".blue.bold
end

listener.start

# Listen on exit signal
at_exit { anybar_notify("white") }
# Cache the packages in project directory
cache_packages(cached_packages)
# Initial run on whole project
go_test(File.join(PROJECT_ROOT, "..."))

# Listen on instructions
loop do
  print "> ".blue.bold

  case $stdin.gets.chomp.strip.downcase
  when /^t(\s+\w+)?$/, /^test(\s+\w+)?$/
    # run all tests in package or in project
    input = $1 ? $1.strip : ""

    if input.empty?
      go_test(File.join(PROJECT_ROOT, "..."))
    elsif pkg = lookup_package(cached_packages, input)
      go_test(File.join(PROJECT_ROOT, pkg, "..."), "-v")
    else
      LOG.info "No package is identified"
    end

  # tf api/api_test.go:32
  # go test github.com/test/data -run TestTest
  when /^tf\s+([\w\/\.]+_test.go):(\d+)?$/, /^testfunc\s+([\w\/\.]+_test.go):(\d+)?$/
    file = $1.strip
    lineno = $2.to_i
    LOG.info "Lookup nearest test: #{file.bold}, lineno: #{lineno}"

    func_name = ""
    File.open(file, 'r') do |f|
      f.each_line do |line|
        break if f.lineno > lineno
        func_name = line =~ /^func ((?:Test|Example)\w+?)\(/ ? $1 : func_name
      end
    end

    if func_name.empty?
      LOG.info "No test func is identified"
    else
      go_test(File.join(PROJECT_ROOT, File.dirname(file)), "-run #{func_name} -v")
    end

  when /^race(\s+\w+)?$/
    # run all tests in package or in project
    input = $1 ? $1.strip : ""

    if input.empty?
      go_test(File.join(PROJECT_ROOT, "..."), "-race")
    elsif pkg = lookup_package(cached_packages, input)
      go_test(File.join(PROJECT_ROOT, pkg, "..."), "-race")
    else
      LOG.info "No package is identified"
    end

  when /^c(\s+\w+)?$/, /^cov(\s+\w+)?$/
    # run coverage tests of package
    input = $1 ? $1.strip : ""

    if input.empty?
      go_test(File.join(last_dir, "..."), "-coverprofile=coverage.out") unless last_dir.empty?
    elsif pkg = lookup_package(cached_packages, input)
      go_test(File.join(PROJECT_ROOT, pkg, "..."), "-coverprofile=coverage.out")
    else
      LOG.info "No package is identified"
    end

  when 'covall', 'cov .', 'c.'
    # run coverage test of all packages
    go_test(File.join(PROJECT_ROOT, "..."), "-cover")

  when 'covreport', 'report', 'rpt'
    `go tool cover -html=coverage.out` # open coverage report

  when 'halt', 'pause'
    listener.pause
    LOG.info "File watcher paused: #{listener.paused?}"

  when 'unhalt', 'go'
    listener.unpause
    LOG.info "File watcher unpaused: #{!listener.paused?}"

  when 'r', 'refresh', 'reload'
    cached_packages = {}
    cache_packages(cached_packages)
    LOG.info "#{cached_packages.size} PACKAGES WITH TESTS:\n#{cached_packages.values.map(&:yellow).join("\n")}"

  when 'q', 'quit', 'exit'
    exit(0)

  else
    LOG.info <<-EOF
    #{"COMMANDS:".blue.bold}

    #{"test [package]".green.bold}: run all tests in the package or in the whole project
    #{"testfunc file:lineno".green.bold}: run nearest test near the line in file
    #{"cov [package]".green.bold}: run coverage test on the package or last triggered packages
    #{"covall".green.bold}: run coverage tests for all packages
    #{"report".green.bold}: open the coverage report in browser
    #{"refresh".green.bold}: refresh the cached packages
    #{"quit".green.bold}: exit script
    EOF
  end
end

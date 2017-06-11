#!/usr/bin/env ruby
# encoding: utf-8

# Run `go test` automatically after file changes
#
# alias wgo="~/dotfiles/scripts/go-test.rb"
#
# Dependency:
#
#   gem install listen
#   gem install colorize
#
# - https://github.com/guard/listen
# - https://github.com/fazibear/colorize
#
# Dependency (Optional):
#
#   brew cask install anybar
#
# - https://github.com/tonsky/AnyBar (optional)
#
require 'logger'
require 'socket'
require 'listen'
require 'colorize'
require 'readline'

LOG = Logger.new(STDOUT)
LOG.level = Logger::INFO
LOG.formatter = proc { |_severity, datetime, _progname, msg| "#{datetime}: #{msg}\n" }

GO_PATH_SRC = File.join(ENV['GOPATH'], 'src', '')
LOG.info("GOPATH: #{ENV['GOPATH'].bold}".blue)

PROJECT_ROOT = Dir.pwd.gsub(GO_PATH_SRC, '')
LOG.info("Listening: #{PROJECT_ROOT.bold}".blue)

# Record the last changed directory
last_dir = PROJECT_ROOT
# Cache all the packages
cached_packages = {}

def anybar_notify(color)
  any_bar = UDPSocket.new
  any_bar.connect 'localhost', 1738
  any_bar.send color, 0
  any_bar.close
end

def cache_packages(pkgs)
  pkgs.clear

  Dir.glob('**/*_test.go') do |file|
    dir = File.dirname(file)
    pkg = File.split(dir).last

    pkgs[pkg] = dir
  end

  true
end

def lookup_package(pkgs, name)
  return nil if name.nil? || name.empty?

  found = nil
  refreshed = false
  loop do
    found = pkgs.find do |pkg, _dir|
      pkg == name || pkg.start_with?(name)
    end

    break if found || refreshed
    refreshed = cache_packages(pkgs)
  end

  if found
    LOG.info "Lookup package: #{name.bold}, found: #{found[1].to_s.bold}".cyan
    found[1]
  else
    LOG.info "Lookup package: #{name.bold}, pkg not found".cyan
    nil
  end
end

def go_test(*args)
  go_cmd("go test #{args.join(' ')}")
end

def go_cmd(cmd)
  LOG.info("Running: #{cmd.bold}".blue)

  anybar_notify('yellow')

  test_passed = true

  IO.popen(cmd, err: [:child, :out]) do |io|
    while line = io.gets
      # shorten and highlight path in line
      line = line.gsub(GO_PATH_SRC, '')
      # shorten project path
      line = line.gsub(PROJECT_ROOT, '.'.yellow)
      line = line.gsub(File.split(PROJECT_ROOT)[0], '..'.yellow)
      line = line.gsub(File.split(File.split(PROJECT_ROOT)[0])[0], '...'.yellow)
      # replace head indication
      line = line.gsub(/^ok\b/, 'ok'.green.bold)
      line = line.gsub(/^FAIL\b/, 'FAIL'.light_yellow.on_red.bold)
      # colorize
      line = case line
             when /^\d{4}.\d\d.\d\d \d\d:\d\d:\d\d/ # log
               line.light_black
                   .gsub(' WARN ', ' WARN '.yellow)
                   .gsub(' ERROR ', ' ERROR '.red)
             when /Error Trace:/, /Error:/, /panic:/, /FAIL:/
               test_passed = false
               line.red
             when /^=+ RUN/
               line.light_cyan
             when /^-+ PASS:/
               line.green
             when /^Benchmark/
               line.gsub(/^(Benchmark[\w-]+) /, '\1 '.green.bold)
             when /coverage: (\d+.\d+)\%/
               cov = Regexp.last_match(1).to_f
               word = "coverage: #{cov}\%".bold
               word = if cov < 70.0 then word.red
                      elsif cov < 85.0 then word.yellow
                      else word.green
                      end
               line.gsub(/coverage: \d+.\d+\%/, word)
             else
               line
             end
      # output line
      print line
    end
  end

  if $CHILD_STATUS.success? && test_passed
    anybar_notify('green')
  else
    anybar_notify(test_passed ? 'exclamation' : 'red') # build fail, or test fail
  end
end

listener = Listen.to(Dir.pwd, only: /\.go$/) do |modified, added, removed|
  unique_paths = {}

  [modified, added, removed].each do |group|
    group.each { |file| unique_paths[File.dirname(file)] = true }
  end

  print "\n" # perfectionism  ┬─┬ ノ( ^_^ノ )

  unique_paths.keys.each do |path|
    relative_path = path.gsub(GO_PATH_SRC, '')
    LOG.info("Detected changes in #{relative_path.gsub(PROJECT_ROOT, '.').bold}".cyan)

    last_dir = relative_path
    go_test(File.join(relative_path, '...'), '-v')
  end

  print '> '.blue.bold
end

listener.start

# Listen on exit signal
at_exit { anybar_notify('white') }
# Trap Ctrl+C
stty_save = `stty -g`.chomp
trap('INT') do
  system('stty', stty_save)
  exit
end

# Cache the packages in project directory
cache_packages(cached_packages)
# Initial run on whole project
go_test(File.join(PROJECT_ROOT, '...')) if ENV['SKIP'].nil?

# Readline autocomplete package names
Readline.completion_proc = proc do |str|
  cached_packages.keys.select { |pkg, _| pkg if pkg.start_with?(str) }
end

# Listen on instructions
while line = Readline.readline('> '.blue.bold, true)
  case line.chomp.strip.downcase

  # run all tests in package or in project
  when /^t(\s+\w+\.?)?$/, /^test(\s+\w+\.?)?$/
    input = Regexp.last_match(1) ? Regexp.last_match(1).strip : ''
    # run in single directory package
    dir = input.end_with?('.') ? (input.chop! && '.') : '...'

    if input.empty?
      go_test(File.join(last_dir, dir)) unless last_dir.empty?
    elsif pkg = lookup_package(cached_packages, input)
      go_test(File.join(PROJECT_ROOT, pkg, dir), '-v')
    else
      LOG.info 'No package is identified'
    end

  # run test of all packages
  when 'ta', 'testall'
    go_test(File.join(PROJECT_ROOT, '...'))

  # example tf api/api_test.go:32
  # go test github.com/test/data -run TestTest
  when /^tf\s+([\w\/\.]+_test.go):(\d+)?$/, /^testfunc\s+([\w\/\.]+_test.go):(\d+)?$/
    file = Regexp.last_match(1).strip
    lineno = Regexp.last_match(2).to_i
    LOG.info "Lookup nearest test: #{file.bold}, lineno: #{lineno}"

    func_name = ''
    File.open(file, 'r') do |f|
      f.each_line do |line|
        break if f.lineno > lineno
        func_name = line =~ /^func ((?:Test|Example)\w+?)\(/ ? Regexp.last_match(1) : func_name
      end
    end

    if func_name.empty?
      LOG.info 'No test func is identified'
    else
      go_test(File.join(PROJECT_ROOT, File.dirname(file)), "-run #{func_name} -v")
    end

  # run race detector in a package or in project
  when /^r(\s+\w+\.?)?$/, /^race(\s+\w+\.?)?$/
    input = Regexp.last_match(1) ? Regexp.last_match(1).strip : ''
    # run in single directory package
    dir = input.end_with?('.') ? (input.chop! && '.') : '...'

    if input.empty?
      go_test(File.join(last_dir, dir), '-race') unless last_dir.empty?
    elsif pkg = lookup_package(cached_packages, input)
      go_test(File.join(PROJECT_ROOT, pkg, dir), '-race')
    else
      LOG.info 'No package is identified'
    end

  # example bf api/api_test.go:32
  # go test -run TestTest -bench . -cpuprofile profile_cpu.out
  when /^bf\s+([\w\/\.]+_test.go):(\d+)?$/, /^benchfunc\s+([\w\/\.]+_test.go):(\d+)?$/
    file = Regexp.last_match(1).strip
    lineno = Regexp.last_match(2).to_i
    LOG.info "Lookup nearest benchmark: #{file.bold}, lineno: #{lineno}"

    func_name = ''
    File.open(file, 'r') do |f|
      f.each_line do |line|
        break if f.lineno > lineno
        func_name = line =~ /^func ((?:Bench)\w+?)\(/ ? Regexp.last_match(1) : func_name
      end
    end

    if func_name.empty?
      LOG.info 'No benchmark func is identified'
    else
      dir = File.dirname(file)
      go_cmd "(cd #{dir} && go test -bench . -run #{func_name} -benchmem -cpuprofile cpu.out -memprofile mem.out)"

      pkg_name = File.basename(dir)
      pprof_cmd = "go tool pprof #{File.join(dir, pkg_name)}.test #{File.join(dir, 'cpu.out')}".bold
      LOG.info "pprof cmd: #{pprof_cmd}".yellow
    end

  # open pprof generated svg graph
  when /^svg(\s+\w+\.?)?$/
    input = Regexp.last_match(1) ? Regexp.last_match(1).strip : ''

    if pkg = lookup_package(cached_packages, input)
      pkg_name = File.basename(pkg)

      `go tool pprof -svg #{File.join(pkg, pkg_name)}.test #{File.join(pkg, 'cpu.out')} > #{File.join(pkg, 'cpu.svg')}`
      `open #{pkg}/cpu.svg`
    else
      LOG.info 'No package is identified'
    end

  # open go-torch https://github.com/uber/go-torch
  when /^torch(\s+\w+\.?)?$/
    input = Regexp.last_match(1) ? Regexp.last_match(1).strip : ''

    if pkg = lookup_package(cached_packages, input)
      pkg_name = File.basename(pkg)

      `go-torch #{File.join(pkg, pkg_name)}.test #{File.join(pkg, 'cpu.out')}`
      `open torch.svg`
    else
      LOG.info 'No package is identified'
    end

  # run coverage tests of package
  when /^c(\s+\w+\.?)?$/, /^cov(\s+\w+\.?)?$/
    input = Regexp.last_match(1) ? Regexp.last_match(1).strip : ''
    # run in single directory package
    dir = input.end_with?('.') ? (input.chop! && '.') : '...'

    if input.empty?
      go_test(File.join(last_dir, dir), '-coverprofile=coverage.out') unless last_dir.empty?
    elsif pkg = lookup_package(cached_packages, input)
      go_test(File.join(PROJECT_ROOT, pkg, dir), '-coverprofile=coverage.out')
    else
      LOG.info 'No package is identified'
    end

  # run coverage test of all packages
  when 'ca', 'covall'
    go_test(File.join(PROJECT_ROOT, '...'), '-cover')

  # open coverage report
  when 'rpt', 'report', 'covreport'
    `go tool cover -html=coverage.out`

  # refresh and list the cached packages with tests
  when 'r', 'l', 'refresh', 'reload'
    cache_packages(cached_packages)
    LOG.info "#{cached_packages.size} PACKAGES WITH TESTS:\n#{cached_packages.values.map(&:yellow).join("\n")}"

  when 'halt', 'pause'
    listener.stop
    LOG.info "File watcher paused: #{listener.paused?}, processing: #{listener.processing?}"

  when 'unhalt', 'unpause'
    listener.start
    LOG.info "File watcher paused: #{!listener.paused?}, processing: #{listener.processing?}"

  # execute any ! commands
  when /^!(.+)$/
    begin
      IO.popen(Regexp.last_match(1).strip, err: [:child, :out]) do |io|
        print line while line = io.gets
      end
    rescue Exception => e
      p e
    end

  when 'q', 'quit', 'exit'
    exit(0)

  else
    LOG.info <<-EOF
    #{'COMMANDS:'.blue.bold}

    #{'test [package]'.green.bold}: run all tests in the package or last triggered packages
    #{'testall'.green.bold}: run all tests in the whole project
    #{'testfunc file:lineno'.green.bold}: run nearest test before the line in file
    #{'race [package]'.green.bold}: run race test in the package or last triggered packages
    #{'benchfunc file:lineno'.green.bold}: run nearest benchmark before the line in file
    #{'svg [package]'.green.bold}: open the generated pprof CPU svg graph in browser
    #{'cov [package]'.green.bold}: run coverage test on the package or last triggered packages
    #{'covall'.green.bold}: run coverage tests for all packages
    #{'report'.green.bold}: open the coverage report in browser
    #{'refresh'.green.bold}: refresh and list the cached packages with tests
    #{'halt'.green.bold}: pause file listener temporary
    #{'unhalt'.green.bold}: unpause file listener
    #{'quit'.green.bold}: exit script
    EOF
  end
end

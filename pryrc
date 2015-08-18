Pry.editor = 'vim'

Pry.commands.alias_command 'c', 'continue' rescue nil
Pry.commands.alias_command 's', 'step' rescue nil
Pry.commands.alias_command 'n', 'next' rescue nil
Pry.commands.alias_command 'r!', 'reload!' rescue nil

begin
  require 'awesome_print'
  AwesomePrint.pry!
rescue LoadError
  puts 'no awesome_print :('
  puts 'gem install awesome_print'
end

begin
  require 'pretty_backtrace'
  PrettyBacktrace.enable
rescue LoadError
  puts 'no pretty_backtrace :('
  puts 'gem install pretty_backtrace'
end

# load gems
{
  'did_you_mean' => nil,
  'pry-byebug' => nil,
  'awesome_print' => ->{ AwesomePrint.pry! },
  'pretty_backtrace' => ->{ PrettyBacktrace.enable },
}.each do |gem, action|
  begin
    require gem
    action.call if action.respond_to? :call
  rescue LoadError
    puts "no #{gem} :("
    puts "gem install #{gem}"
  end
end

# pry-byebug alias
if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

# hit Enter to repeat last command
# Pry::Commands.command /^$/, "repeat last command" do
#   _pry_.run_command Pry.history.to_a.last
# end

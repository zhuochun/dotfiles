{
  'did_you_mean' => nil,
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

begin
  require 'awesome_print'
  AwesomePrint.irb!
rescue LoadError
  puts "no awesome_print :("
  puts "gem install awesome_print"
end

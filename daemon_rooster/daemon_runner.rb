require 'rubygems'
require 'daemons'
puts [File.dirname(__FILE__), 'tiny_schedulers.rb'].join("/")
Daemons.run([File.dirname(__FILE__), 'tiny_schedulers.rb'].join("/"), {
  :backtrace => true
})

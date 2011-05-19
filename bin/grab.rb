#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'grabber'

filename = Pathname.new(__FILE__).basename

if ARGV.length == 0
  puts "Help   : ./#{filename} url [path]"
  puts "         Path is optional. Default value is '/tmp'"
  puts "Example: ./#{filename} http://google.com /tmp/google"
  exit 1
end

grabber = Grabber.new
files = grabber.grab_images_from ARGV[0], :to => ARGV[1]
puts "downloaded #{files.length} file(s)"
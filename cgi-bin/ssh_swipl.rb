#!/usr/bin/ruby

require 'json'
require 'open3'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/gpg-lib'
require_relative 'ruby-lib/eigen-lib'
require_relative 'ruby-lib/swipl-lib'

exit 10 if ARGV.length == 0
swipl_path = ARGV[0]
swipl_goal = ARGV[1]

ruby_string = "swipl_test(\"#{swipl_path}\", \"#{swipl_goal}\")"
puts eval(ruby_string)

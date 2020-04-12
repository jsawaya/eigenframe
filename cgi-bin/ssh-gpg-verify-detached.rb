#!/usr/bin/ruby

require 'json'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/gpg-lib'

exit 10 if ARGV.length == 0 

sig_file = ARGV[0]
original_file = ARGV[0]

puts gpg_verify(sig_file, original_file).to_json.to_s

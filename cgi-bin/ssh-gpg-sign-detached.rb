#!/usr/bin/ruby

require 'json'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/gpg-lib'

exit 10 if ARGV.length == 0 

keyid = ARGV[0]
password = ARGV[1]
input_file = ARGV[2]

puts gpg_sign_detached(keyid, password, input_file).to_json.to_s
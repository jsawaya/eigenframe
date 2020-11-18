#!/usr/bin/ruby

require 'json'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/gpg-lib'

exit 10 if ARGV.length == 0 

input_file = ARGV[0]
keyid = ARGV[1]
password = ARGV[2]

puts gpg_sign_detached(keyid, password, input_file).to_json.to_s
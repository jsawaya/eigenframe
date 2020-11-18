#!/usr/bin/ruby

require 'json'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/gpg-lib'

exit 10 if ARGV.length == 0 

keyid = ARGV[0]
infile = ARGV[1]
fmt = ARGV[2]

puts gpg_encrypt(keyid, infile, fmt).to_json.to_s

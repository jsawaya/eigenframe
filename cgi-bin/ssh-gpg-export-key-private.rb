#!/usr/bin/ruby

require 'json'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/gpg-lib'

exit 10 if ARGV.length == 0 

keyid = ARGV[0]
password = ARGV[1]

puts gpg_export_private_key(keyid, password)

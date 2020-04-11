#!/usr/bin/ruby

require 'json'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/gpg-lib'

exit 10 if ARGV.length == 0 

keyfile = ARGV[0]
password = ARGV[1]

puts gpg_import_private_key(keyfile, password)

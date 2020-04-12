#!/usr/bin/ruby

require 'json'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/gpg-lib'

exit 10 if ARGV.length == 0 

keyfile = ARGV[0]
password = ARGV[1]
keyid = ARGV[2]

puts gpg_sign_detached(keyid, password, keyfile)
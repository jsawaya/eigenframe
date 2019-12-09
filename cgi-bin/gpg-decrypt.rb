#!/usr/bin/ruby

require 'json'
require './ruby-lib/app-lib'
require './ruby-lib/gpg-lib'

exit 10 if (ARGV.length != 3) 

password = ARGV[0]
keyfile = ARGV[1]
outfile = ARGV[2]

puts gpg_decrypt(password, keyfile, outfile)

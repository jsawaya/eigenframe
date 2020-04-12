#!/usr/bin/ruby
# 'ruby ssh-gpg-decrypt.rb ' + encrypted_file + ' ' + output_file + ' \"' + password + '\"' "

require 'json'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/gpg-lib'

exit 10 if ARGV.length == 0 

pgpfile = ARGV[0]
outfile = ARGV[1]
password = ARGV[2]

puts gpg_decrypt(password, pgpfile, outfile).to_json.to_s

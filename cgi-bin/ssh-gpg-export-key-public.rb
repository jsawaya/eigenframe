#!/usr/bin/ruby

require 'json'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/gpg-lib'

exit 10 if ARGV.length == 0 

keyid = ARGV[0]

puts gpg_export_public_key(keyid).to_json.to_s

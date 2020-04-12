#!/usr/bin/ruby
# 'ruby ssh-gpg-decrypt.rb ' + encrypted_file + ' \"' + password + '\"' "

require 'json'
require 'fileutils'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/gpg-lib'

exit 10 if ARGV.length == 0 

pgpfile = ARGV[0]
password = ARGV[1]

outfile = encrypted_file[0..(encrypted_file.rindex('.')-1)]
if File.exist? outfile
	puts "file already exists: ${outfile}"
	exit 20
end

puts gpg_decrypt(password, pgpfile, outfile).to_json.to_s

#!/usr/bin/ruby 

require 'open3'
require 'cgi'
require 'json'
require 'fileutils'
require './ruby-lib/app-lib'

print_response_header

cgi = CGI.new

exit 10 if !cgi.has_key?('zip_name')
exit 11 if !cgi.has_key?('zip_path')

zip_name = cgi.params['zip_name'][0]

#zip_path = "/data/data/com.termux/files/home/storage/shared/Android/data/com.termux/files"
zip_path = cgi.params['zip_path'][0]

Dir.chdir zip_path

File.delete zip_name if File.exist? zip_name

home = "/data/data/com.termux/files/home"
usr = "/data/data/com.termux/files/usr"

files = "#{usr}/share/apache2/default-site/htdocs/*.html"
puts sysops("sysops-zip-html", "zip -v #{zip_name} #{files}")
puts "---------------------------------------------------------------------------------------"

dir = "#{usr}/lib/cgi-bin"
puts sysops("sysops-zip-cgi", "zip -x \*~ -vry #{zip_name} #{dir}")
puts "---------------------------------------------------------------------------------------"

dir = "#{usr}/etc/apache2/extra"
puts sysops("sysops-zip-extra", "zip -x \*~ -vry #{zip_name} #{dir}")
puts "---------------------------------------------------------------------------------------"

files = "#{usr}/etc/apache2/httpd.conf"
puts sysops("sysops-zip-conf", "zip -v #{zip_name} #{files}")
puts "---------------------------------------------------------------------------------------"

files = "#{home}/*.sh"
puts sysops("sysops-zip-home-sh", "zip -v #{zip_name} #{files}")
puts "---------------------------------------------------------------------------------------"

zip0 = "backup_0.zip"
zip1 = "backup_1.zip"
zip2 = "backup_2.zip"
zip3 = "backup_3.zip"
zip4 = "backup_4.zip"
zip5 = "backup_5.zip"

File.delete(zip5) if File.exist? zip5
FileUtils.cp(zip4, zip5) if File.exist? zip4
FileUtils.cp(zip3, zip4) if File.exist? zip3
FileUtils.cp(zip2, zip3) if File.exist? zip2
FileUtils.cp(zip1, zip2) if File.exist? zip1
FileUtils.cp(zip0, zip1) if File.exist? zip0
FileUtils.cp(zip_name, zip0) if File.exist? zip_name
puts "---------------------------------------------------------------------------------------"

puts sysops("sysops-list-download-termux", "ls -la")
puts "---------------------------------------------------------------------------------------"

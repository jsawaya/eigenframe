#!/usr/bin/ruby

require 'open3'
require 'cgi'
require 'json'
require './ruby-lib/app-lib'

print_response_header

shared_path = "/data/data/com.termux/files/home/storage/shared/Android/data/com.termux/files"

cgi = CGI.new

zip_path = shared_path
if cgi.has_key?('zip_path')
  zip_path = cgi.params['zip_path'][0]
end

if File.exist?(zip_path) && File.directory?(zip_path)

  Dir.chdir zip_path

  home = "/data/data/com.termux/files/home"
  usr = "/data/data/com.termux/files/usr"

  zip_name = "backup-public.zip"
  if cgi.has_key?('zip_name')
    zip_name = cgi.params['zip_name'][0]
  end

  puts sysops("sysops-unzip-restore", "unzip -o #{zip_name} -d /")
  puts "---------------------------------------------------------------------------------------"

  puts sysops("sysops-chmod-cgi", "chmod 755 #{usr}/lib/cgi-bin/*.sh")
  puts "---------------------------------------------------------------------------------------"

  puts sysops("sysops-chmod-rb", "chmod 755 #{usr}/lib/cgi-bin/*.rb")
  puts "---------------------------------------------------------------------------------------"

  puts sysops("sysops-chmod-sh", "chmod 755 #{home}/*.sh")
  puts "---------------------------------------------------------------------------------------"

  create_symlink("#{usr}/lib/cgi-bin",
                 "#{home}/apache2-cgi")

  create_symlink("#{usr}/etc/apache2",
                 "#{home}/apache2-config")

  create_symlink("#{usr}/share/apache2/default-site/htdocs",
                 "#{home}/apache2-html")

  create_symlink("#{usr}/var/log/apache2",
                 "#{home}/apache2-logs")

  create_symlink("#{shared_path}",
                 "#{home}/external-share")

else
  puts "zip_path not found"
  
end

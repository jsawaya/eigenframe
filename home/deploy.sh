#!/usr/bin/sh

# install apache2 configuation
cp /data/data/com.termux/files/home/git-repos/eigenframe/etc-apache2/httpd.conf /data/data/com.termux/files/usr/etc/apache2

# enable cgi-bin file execution
chmod 755 /data/data/com.termux/files/home/git-repos/eigenframe/cgi-bin/*



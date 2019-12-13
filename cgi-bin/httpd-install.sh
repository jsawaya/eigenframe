#!/usr/bin/sh

echo "install apache2 httpd - if it's not installed"
pkg install apache2

echo "stop apache2 httpd - if it's running"
killall httpd

echo "remove old apache2 process - if it exists"
rm /data/data/com.termux/files/usr/var/run/apache2/httpd.pid

echo "backup old apache2 configuation - todo: add if not exists"
cp /data/data/com.termux/files/usr/etc/apache2/httpd.conf ~/original-httpd.conf.backup 

echo "install apache2 configuation"
cp /data/data/com.termux/files/home/git-repos/eigenframe/etc-apache2/httpd.conf /data/data/com.termux/files/usr/etc/apache2

echo "enable execution of cgi-bin directory files"
chmod 755 /data/data/com.termux/files/home/git-repos/eigenframe/cgi-bin/*

echo "start apache2 httpd..."
httpd&

echo "ready to test - set web-browser to url -> localhost:8080/cgi-bin/sys-test.sh"


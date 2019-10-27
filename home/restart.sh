#!/usr/bin/sh

echo "end all httpd processes"
killall httpd

echo "remove httpd process id"
rm /data/data/com.termux/files/usr/var/run/apache2/httpd.pid

echo "start apache2 httpd..."
httpd&

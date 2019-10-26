#!/usr/bin/sh

echo ps -e
ps -e

echo ls httpd.pid
ls -la /data/data/com.termux/files/usr/var/run/apache2/httpd.pid

echo cat httpd.pid
cat /data/data/com.termux/files/usr/var/run/apache2/httpd.pid

echo rm httpd.pid
rm /data/data/com.termux/files/usr/var/run/apache2/httpd.pid

#echo stop httpd

echo starting httpd
httpd&

echo ps -e
ps -e

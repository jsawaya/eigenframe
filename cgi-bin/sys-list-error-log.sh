#!/bin/sh
#!/usr/bin/sh
set -f

echo "Content-type: text/plain; charset=iso-8859-1"
echo

echo /data/data/com.termux/files/usr/var/log/apache2/error_log:
tail /data/data/com.termux/files/usr/var/log/apache2/error_log
echo -- eof --

echo /var/log/apache2/error.log:
tail /var/log/apache2/error.log
echo -- eof --



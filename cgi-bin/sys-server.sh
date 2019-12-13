#!/bin/sh
#!/usr/bin/sh
set -f

echo "Content-type: text/plain; charset=iso-8859-1"
echo

echo CGI/1.0 eigen script:
echo

echo env:
env
echo

echo pwd:
pwd
echo

echo ps:
ps
echo

echo df:
df
echo

echo ruby:
ruby -v
echo


echo files:
ls -la
echo -- eof --



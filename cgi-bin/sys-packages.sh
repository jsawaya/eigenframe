#!/bin/sh
#!/usr/bin/sh

set -f

echo "Content-type: text/plain; charset=iso-8859-1"
echo

echo list-all packages:
pkg list-all
echo

echo -- eof --



#!/bin/sh
#!/usr/bin/sh
set -f

cd swipl-lib

echo "Content-type: text/plain; charset=iso-8859-1"
echo

echo swi-prolog:
echo =========================================================================
cat routes.pl
echo =========================================================================
echo
echo goal:
echo $QUERY_STRING
echo

echo "" > swipl.out
echo "" > err.out

swipl -s routes.pl -g "$QUERY_STRING" -t halt  > swipl.out 2> err.out

echo output:
cat swipl.out
echo

echo =========================================================================
cat err.out
echo

echo -- eof --



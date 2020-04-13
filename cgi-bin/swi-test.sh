#!/bin/sh
#!/usr/bin/sh
set -f

echo "Content-type: text/plain; charset=iso-8859-1"
echo

cd swipl-lib
pwd

echo swi-prolog:
echo =========================================================================
cat swipl.pl
echo =========================================================================
echo
echo goal:
echo $QUERY_STRING
echo

echo "" > swipl.out
echo "" > err.out

swipl -s swipl.pl -g "$QUERY_STRING" -t halt  > swipl.out 2> err.out

echo output:
cat swipl.out
echo

echo =========================================================================
#cat err.out
#echo

echo -- eof --


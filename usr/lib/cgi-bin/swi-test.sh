#!/bin/sh
#!/usr/bin/sh
set -f

# curl localhost:8080/cgi-bin/sudoku.cgi?problem\(1,Rows\),sudoku\(Rows\),write\(Rows\),nl

echo "Content-type: text/plain; charset=iso-8859-1"
echo

#cd /data/data/com.termux/files/home/storage/downloads/termux-files/swipl
cd swipl-lib
ls

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


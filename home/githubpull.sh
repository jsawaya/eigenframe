#!/usr/bin/sh

git status
git checkout master
git pull
git checkout test
git merge master

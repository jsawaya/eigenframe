#!/usr/bin/sh
echo git log --branches --not --remotes:
git log --branches --not --remotes

echo git status:
git status

echo git checkout master:
git checkout master

echo git pull:
git pull

echo git checkout test:
git checkout test

echo git merge master:
git merge master

echo git status:
git status

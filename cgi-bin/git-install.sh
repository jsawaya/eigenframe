echo cd ~
cd ~

echo pkg install git
pkg install git

echo mkdir git-repos
mkdir git-repos

echo cd git-repos
cd git-repos

echo git clone https://github.com/jsawaya/eigenframe
git clone https://github.com/jsawaya/eigenframe

echo cd eigenframe
cd eigenframe

echo git checkout -b test
git checkout -b test

echo git status
git status

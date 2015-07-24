#!/bin/bash

# Do an initial git clone if /proxmark3/git doesn't contain a git repo
[ ! -d /proxmark3/git/.git ] && git clone https://github.com/Proxmark/proxmark3.git /proxmark3/git

# Cleanup source dir and pull latest
cd /proxmark3/git
make clean
git pull -u origin master

# Build
make

# Create tarball
GIT_VERSION=`git rev-parse --short HEAD`
make tarbin
mv /proxmark3/git/proxmark3-Linux-bin.tar.gz /packages/proxmark3-Linux-x86_64-$GIT_VERSION.tar.gz && echo "Proxmark3 x86_64 can be found at /packages/proxmark3-Linux-x86_64-$GIT_VERSION.tar.gz. Copy it via 'docker cp' and you're good to go!"

#!/usr/bin/env bash
set -ex
root=$(dirname $(readlink -f $0))
remote_url=$1
git remote set-url origin $remote_url
git fetch origin master
git checkout -b master FETCH_HEAD
git log -1
cp -r ${root}/.tmp/* ${root}
if [ "$(git status -s)" != "" ]; then
    git add .
    git commit -m "$(date -u +'%Y-%m-%d %H:%M:%S%z')"
    git push origin master:master
fi
git checkout write

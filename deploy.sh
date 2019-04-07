#!/usr/bin/env bash
source_dir=$1
remote_url=$2
ssh worker@118.25.23.188 -i ~/.ssh/id_rsa << EOF
set -ex
cd ~/$source_dir
docker-compose down
cd ~
rm -rf $source_dir
git clone $remote_url
cd $source_dir
docker-compose up --build -d &
sleep 3
exit
EOF
echo done!
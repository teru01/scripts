#!/bin/bash

set -ux

cd "${0%/*}"

dir="${1%/}"
sudo cp -a /var/log/mysql/mysql-slow.log $dir
sudo cp -a /var/log/nginx/access.log $dir
cp kataribe.toml $dir
cat $dir/access.log | kataribe > $dir/result.txt

# パーミッションまわり調整
sudo chown -R $USER:$GROUPS $dir
pt-query-digest $dir/mysql-slow.log > $dir/digest.txt

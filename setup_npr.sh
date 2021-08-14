#!/bin/bash

set -ux

cd "${0%/*}"

dir=$(date +%Y-%m-%d-%H-%M-%S)
mkdir $dir
touch $dir/$dir

sudo rm /var/log/nginx/access.log
sudo rm /var/log/mysql/slow.log
sudo systemctl restart nginx
sudo systemctl restart mysqld

echo $dir

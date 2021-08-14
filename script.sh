#!/bin/bash

set -u
shopt -s dotglob

PROJ_DIR=$1

yes "" | sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install -y nginx dstat percona-toolkit sysstat curl git build-essential tree net-tools vim unzip
go get -u github.com/matsuu/kataribe
go get -u github.com/google/pprof

cd $PROJ_DIR

#######################
# 計測スクリプト
#######################

curl -LO https://github.com/teru01/scripts/archive/master.zip
unzip master.zip
rm master.zip
mv scripts-master/* .
rm -r scripts-master

chmod +x pprof_npr.sh
chmod +x setup_npr.sh
chmod +x summarize_npr.sh

$(go env GOPATH)/bin/kataribe -generate

#!/bin/bash

set -u
shopt -s dotglob

PROJ_DIR=$1

yes "" | sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install -y nginx dstat percona-toolkit sysstat curl git build-essential tree net-tools vim unzip
go get -u github.com/matsuu/kataribe
go get -u github.com/google/pprof

curl -LO https://github.com/teru01/log2discord/releases/download/1.0/log2discord
chmod +x log2discord
sudo mv log2discord /bin


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

sudo systemctl stop apparmor
sudo systemctl disable apparmor

sudo systemctl stop ufw
sudo systemctl disable ufw

cat <<EOF > ~/.tmux.conf
set -g mouse on
unbind C-b
set -g prefix C-g
bind C-b send-prefix

# scroll buffer
set -g history-limit 65535

EOF

tmux source-file ~/.tmux.conf

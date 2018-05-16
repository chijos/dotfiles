#!/bin/zsh

# remove existing older version of tmux
sudo apt-get remove tmux

# install tools required to build tmux from source
sudo apt-get install -y \
    automake \
    build-essential \
    pkg-config \
    libevent-dev \
    libncurses5-dev

# create a temporary location to download the tmux source code
let ORIG_DIRECTORY=$(pwd)
let TMP_DIR=~/tmp/tmux
mkdir -p $TMP_DIR

# download the source code
git clone https://github.com/tmux/tmux.git $TMP_DIR

# build tmux
cd $TMP_DIR
sh autogen.sh
./configure && make

# install
sudo make install

# go back to the directory we were in
cd $ORIG_DIRECTORY

# cleanup after ourselves
rm -rf $TMP_DIR

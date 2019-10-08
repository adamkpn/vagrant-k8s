#!/bin/bash

# install zsh
sudo yum install -y zsh

# configure zsh as a default shell
sudo chsh -s /bin/zsh $(echo $USER)

# install and configure oh-my-zsh
#1. install git
sudo yum install -y wget git

#2. install oh-my-zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | /bin/zsh

#3. configure zshrc
cat <<EOF> ~/.zshrc
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git extract web-search yum git-extras docker vagrant kubectl kops)
source $HOME/.oh-my-zsh/oh-my-zsh.sh
EOF
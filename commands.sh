#!/bin/bash

sudo -v

while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if [ -x /usr/local/bin/brew ]; then
    echo homebrew already exists. skip installing homebrew.
else
    echo homebrew does not exists. installing homebrew...
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo installing brew packages.
sh ./brew.sh

if [ -x /bin/zsh ]; then
    echo zsh exists. setting as default
    chsh -s /bin/zsh
else
    echo zsh does not exist. install to use oh-my-zsh
fi



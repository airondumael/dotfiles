#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

E='\033[1;30m[exists]'
I='\033[1;32m[installed]'
R='\033[0m'

install () {
  if [ -e "$HOME/$2" ]; then
    echo -e $2 $E$R
    read -p "Replace existing? (y/n) " -n 1
    echo
  fi
  if ([ ! -e "$HOME/$2" ] || [[ $REPLY =~ ^[Yy]$ ]]); then
    rm -r $HOME/$2 > /dev/null 2>&1
    ln -s `pwd`/$1 $HOME/$2 && echo -e $2 $I$R
  fi
  echo
}

echo '\003[1:32m' setting osx '\003[0m'
sh ./osx/osx.sh

echo '\003[1:32m' Creating symbolic link '\003[0m'
install vim .vim
install vim/vimrc .vimrc
install zsh/zshrc .zshrc
install git/gitignore .gitignore
install git/gitignore_global .gitignore_global

echo '\003[1:32m' installing brew '\003[0m'
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

echo '\003[1:32' tap and install '\003[0m'

brew tap homebrew/dupes
brew tap homebrew/versions

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

brew install \
    macvim --override-system-vim \
    cmake \
    the_silver_searcher \
    moreutils \
    findutils \
    gnu-sed --with-default-names \
    wget --with-iri \
    homebrew/dupes/grep \
    ack \
    git \
    imagemagick --with-webp \
    lua \
    lynx \
    p7zip \
    pigz \
    pv \
    rename \
    rhino \
    speedtest_cli \
    tree \
    webkit2png \
    zopfli \
    aria2 \
    node

brew cask install \
    caffeine \
    dropbox \
    firefox \
    google-chrome \
    iterm2 \
    steam \
    slack \
    spectacle

brew cleanup

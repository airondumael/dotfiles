#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

install () {
  if [ -e "$HOME/$2" ]; then
    echo "linking $HOME/$2"
    read -p "Replace existing? (y/n) " -n 1
    echo
  fi
  if ([ ! -e "$HOME/$2" ] || [[ $REPLY =~ ^[Yy]$ ]]); then
    rm -r $HOME/$2 > /dev/null 2>&1
    ln -s `pwd`/$1 $HOME/$2 && echo -e $2 $I$R
  fi
  echo
}

sh ./osx/osx.sh

install vim .vim
install vim/vimrc .vimrc
install zsh/zshrc .zshrc
install git/gitignore .gitignore
install git/gitignore_global .gitignore_global

echo "install brew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

echo "tap && install formula"

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
    hub \
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
    caskroom/cask/brew-cask \
    mplayer \
    node

brew cask install \
    caffeine \
    dropbox \
    firefox \
    google-chrome \
    iterm2 \
    steam \
    slack \
    keepassx \
    github \
    vlc \
    skype \
    mplayerx \
    spotify \
    spectacle

brew cleanup

#!/bin/bash
set -eu
#set -x

TSTAMP=`date +%Y%m%d%H%M`

#######################################
# Install Dependencies
#######################################

if !(type curl > /dev/null 2>&1); then
    echo "Start curl command installation"
    sudo apt-get -y install curl
fi

if !(type vim > /dev/null 2>&1); then
    echo "Start vim command installation"
    sudo apt-get -y install vim
fi

if !(type nvim > /dev/null 2>&1); then
    echo "Start nvim command installation"
    sudo apt-get -y install neovim
fi

if !(type tig > /dev/null 2>&1); then
    echo "Start tig command installation"
    sudo apt-get -y install tig
fi

#######################################
# Setup dotfiles
#######################################

# Move dotfiles directory
BASEDIR=$(dirname $0)
cd $BASEDIR

# Create backup directory
if [ ! -d $HOME/.dotfiles.old ]; then
    echo "Create backup directory."
fi
mkdir -p $HOME/.dotfiles.old/$TSTAMP

echo "Create dotfile links."
for f in .??*; do
    # Ignore files
    [ $f = ".git" ] && continue
    [ $f = ".gitignore" ] && continue
    [ $f = ".github" ] && continue

    # Backup if already exists
    if [ -e $HOME/$f ]; then
        mv $HOME/$f $HOME/.dotfiles.old/$TSTAMP/
    fi
    ln -snfv $(pwd)/$f $HOME/$f
done

# Back .profile when Debian
if [ -f /etc/debian_version ] && [ -f $HOME/.profile ]; then
    mv $HOME/.profile $HOME/.dotfiles.old/$TSTAMP/
fi

echo "Success"
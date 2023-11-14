#!/bin/bash
set -eu
#set -x

TSTAMP=`date +%Y%m%d%H%M`

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
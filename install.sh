#!/bin/bash

# Directory containing config files
CONFIGDIR=~/dotfiles

# Directory to hold prev config files
BCKDIR=~/.dotfiles_old

# exclude this install script
EXCLUDEFILE=$(basename "$0")

if [ ! -d "$CONFIGDIR" ]; then
    exit 1
fi

# Files to backup and replace
FILES=`ls $CONFIGDIR`

if [ ! -d "$BCKDIR" ]; then
    mkdir -p "$BCKDIR"
fi

for file in $FILES
do

    if [ "$file" == "$EXCLUDEFILE" ]; then
        continue
    fi
    # Save previous config file
    if [ -f ~/.$file ] || [ -d ~/.$file ]; then
        # f to force copy stubborn objects
        # R to copy directories if necessary
        # L to follow symlink and make a hard copy
        cp -fRL ~/.$file $BCKDIR
    fi

    # Create symlink to config file in Home dir
    ln -fs $CONFIGDIR/$file ~/.$file
done

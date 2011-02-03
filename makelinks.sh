#!/bin/sh

DOTDIR="$(pwd)"

ln -s $DOTDIR/bash_profile     ~/.bash_profile 
ln -s $DOTDIR/bin              ~/bin
ln -s $DOTDIR/emacs.d          ~/.emacs.d
ln -s $DOTDIR/gitconfig        ~/.gitconfig
ln -s $DOTDIR/irbrc            ~/.irbrc

#!/usr/bin/env bash

DOTFILES_DIR=~/dotfiles

#==========
# Delete pre-existing dot files and folders
#==========
rm -rf ~/.bash_profile > /dev/null 2>&1
rm -rf ~/.bash_aliases > /dev/null 2>&1
rm -rf ~/.bashrc > /dev/null 2>&1
rm -rf ~/.tmux.conf > /dev/null 2>&1
rm -rf ~/.vimrc > /dev/null 2>&1
rm -rf ~/.vim > /dev/null 2>&1

#==========
# Create symlinks in home
#==========
ln -sf $DOTFILES_DIR/bash/bash_profile ~/.bash_profile
ln -sf $DOTFILES_DIR/bash/bash_aliases ~/.bash_aliases
ln -sf $DOTFILES_DIR/bash/bashrc ~/.bashrc
ln -sf $DOTFILES_DIR/tmux/tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/vim/vimrc ~/.vimrc
ln -sf $DOTFILES_DIR/vim ~/.vim

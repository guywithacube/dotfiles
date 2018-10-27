#!/usr/bin/env bash

DOTFILES_DIR=~/dotfiles

#==========
# Delete pre-existing dot files and folders
#==========
# > /dev/null 2>&1
printf "Removing any existing directories\n"
rm -rfv ~/.bash_profile
rm -rfv ~/.bash_aliases
rm -rfv ~/.bashrc
rm -rfv ~/.tmux.conf
rm -rfv ~/.vimrc
rm -rfv ~/.vim
printf "\n"

#==========
# Create symlinks in home
#==========
printf "Creating symbolic links\n"
ln -sfv $DOTFILES_DIR/bash/bash_profile ~/.bash_profile
ln -sfv $DOTFILES_DIR/bash/bash_aliases ~/.bash_aliases
ln -sfv $DOTFILES_DIR/bash/bashrc ~/.bashrc
ln -sfv $DOTFILES_DIR/tmux/tmux.conf ~/.tmux.conf
ln -sfv $DOTFILES_DIR/vim/vimrc ~/.vimrc
ln -sfv $DOTFILES_DIR/vim ~/.vim
printf "\n"

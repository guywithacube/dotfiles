#!/usr/bin/env bash

#==========
# GNU Make Autocompletion
#==========
# https://stackoverflow.com/a/38415982
complete -W "\`grep -oE '^[a-zA-Z0-9_-][a-zA-Z0-9_.-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make

#==========
# Spellcheck cd
#==========
# Correct minor typos when changing directories
shopt -s cdspell

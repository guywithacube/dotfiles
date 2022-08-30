#!/usr/bin/env bash

#==========
# Vi editing
#==========
# Set editing mode to use vi style
bind "set editing-mode vi"
# Only give 0.15 sec for ambiguous key sequences
# https://unix.stackexchange.com/a/318497
bind "set keyseq-timeout 150"

# Show vi mode
bind "set show-mode-in-prompt on"
# Insert mode
bind 'set vi-ins-mode-string ""'
# Normal mode
bind 'set vi-cmd-mode-string "(cmd) "'

#==========
# Color
#==========
# Colorize autocompleted text
if $SUPPORTS_COLORS; then
	bind "set colored-stats on"
fi

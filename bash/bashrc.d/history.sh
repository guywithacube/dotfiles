#!/usr/bin/env bash

#==========
# History
#==========
# Don't put duplicate lines/lines with spaces in history.
#HISTCONTROL=ignoreboth
HISTCONTROL="ignorespace:ignoredups"

# Set history length
# https://stackoverflow.com/a/19454838
HISTSIZE=1000     # stored in memory
HISTFILESIZE=8000 # stored on disk

# Append to the history file (don't overwrite).
shopt -s histappend

# Flush to history file after every command
# https://askubuntu.com/a/80380
# https://stackoverflow.com/a/36669770
export PROMPT_COMMAND="flushToHistory;$PROMPT_COMMAND"
flushToHistory() {
	history -a
	history -r
}

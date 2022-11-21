#!/usr/bin/env bash

# Don't put duplicate lines/lines with spaces in history.
HISTCONTROL="ignorespace:ignoredups"

# Set history length
# https://stackoverflow.com/a/19454838
HISTSIZE=5000     # stored in memory
HISTFILESIZE=5000 # stored on disk

# Append to the history file (don't overwrite).
shopt -s histappend

# Flush to history file after every command
# https://askubuntu.com/a/80380
# https://stackoverflow.com/a/36669770
if [[ "$PROMPT_COMMAND" != *"flushToHistory"* ]]; then
	export PROMPT_COMMAND="flushToHistory"
fi
flushToHistory() {
	history -a
	history -r
}

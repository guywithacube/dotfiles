#!/usr/bin/env bash

#==========
# Configure color
#==========
COLOR_PROMPT=false
case "$TERM" in
	xterm-color | *-256color)
		COLOR_PROMPT=true
		;;
esac


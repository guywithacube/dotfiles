#!/usr/bin/env bash

#==========
# Custom prompt
#==========
if $COLOR_PROMPT; then
	# PS1 Bash escaping
	# https://unix.stackexchange.com/a/28828
	# PS1 Bash prompt escape sequences:
	# http://tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html
	#              a         1    b         2   c            d
	#              |         |    |         |   |            |
	#              v         v    v         v   v            v
	export PS1="\[\e[1;92m\]\h:\[\e[1;34m\]\w\[\e[0m\] \\$ \[$(tput sgr0)\]"
	#  a) bold green                 |   1) hostname
	#  b) bold blue                  |   2) current directory
	#  c) clear all effects          |   3) user input
	#  d) clear all effects via tput
else
	#            1  2
	#            |  |
	#            v  v
	export PS1="\h:\w \\$ "
fi

#==========
# Terminal title
#==========
case "$TERM" in
	xterm* | rxvt*)
		# NOTE: xterm OSC escape sequences from http://tldp.org/HOWTO/Xterm-Title-3.html
		#       - ESC]0;stringBEL : Set icon name and window title to string
		#       - ESC]1;stringBEL : Set icon name to string
		#       - ESC]2;stringBEL : Set window title to string
		export PS1="\[\e]0;\h:\w\007\]$PS1"
		;;
esac

#!/usr/bin/env bash

# Non-printing characters need to be escaped
# https://superuser.com/a/301355
COLORED_PS1="\[\e[0m\]\[\e[33m\]\u@\h\[\e[0m\]\[\e[37m\]:\[\e[0m\]\[\e[32m\]\w\[\e[0m\]\n\\$ \[\e[0m\]"
if $SUPPORTS_COLORS; then
	export PS1=$COLORED_PS1
else
	# Save extglob option
	saved_shopt_extglob="$(shopt -p extglob)"

	# Enable extglob
	shopt -s extglob
	# Remove occurrences of `\[` or `\]`
	REMOVE_NON_PRINTING_ESCAPES=${COLORED_PS1//@(\\\[|\\\])/}
	# Remove occurrences of ANSI SGR escapes
	REMOVE_ANSI_ESCAPES=${REMOVE_NON_PRINTING_ESCAPES//@(\\e|\\033)\[*([[:digit:];])m/}
	export PS1=$REMOVE_ANSI_ESCAPES

	# Restore original extglob option
	eval "$saved_shopt_extglob"
fi

# Terminal title
case "$TERM" in
	xterm* | rxvt*)
		# NOTE: xterm OSC escape sequences from http://tldp.org/HOWTO/Xterm-Title-3.html
		#       - ESC]0;stringBEL : Set icon name and window title to string
		#       - ESC]1;stringBEL : Set icon name to string
		#       - ESC]2;stringBEL : Set window title to string
		export PS1="\[\e]0;\h:\w\007\]$PS1"
		;;
esac

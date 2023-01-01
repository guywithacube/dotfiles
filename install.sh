#!/usr/bin/env bash

# https://stackoverflow.com/a/9107028
SCRIPTPATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR=$SCRIPTPATH

# linked_files is used to configure the dotfiles/configurations managed by this
# install script.
declare -a linked_files=(
	# File managed by this install script should follow this format:
	# "source_file|target_file"
	"$DOTFILES_DIR|$HOME/.dotfiles"
	"$DOTFILES_DIR/bash/bash_profile|$HOME/.bash_profile"
	"$DOTFILES_DIR/bash/bash_aliases|$HOME/.bash_aliases"
	"$DOTFILES_DIR/bash/bashrc|$HOME/.bashrc"
	"$DOTFILES_DIR/tmux/tmux.conf|$HOME/.tmux.conf"
	"$DOTFILES_DIR/vim/vimrc|$HOME/.vimrc"
	"$DOTFILES_DIR/vim|$HOME/.vim"
)

function echo_stderr() {
	# callstack_depth is the depth of the call stack, excluding this function
	# and main
	local callstack_depth="$((${#FUNCNAME[@]} - 2))"
	printf "%*s%s: %s\n" "$((callstack_depth * 4))" "" "${FUNCNAME[1]}" "$*" 1>&2
}

# For each linked configuration file, a callback function is called.
# The callback function is passed two parameters: source_file and target_file.
#
# Parameters:
#   callback - function
# Returns:
#   0 if all callbacks ran successfully, non-zero otherwise.
function for_each_linked_file() {
	if [ $# -ne 1 ]; then
		echo_stderr "too many arguments provided"
		return 1
	fi

	local callback=$1

	for entry in "${linked_files[@]}"; do
		IFS="|" read -r -a linked_file_tuple <<< "$entry"

		local \
			source_file=${linked_file_tuple[0]} \
			target_file=${linked_file_tuple[1]} \
			return_value

		$callback "$source_file" "$target_file"
		# Save return_value so it can be preserved for an error message
		return_value=$?
		if [ $return_value -ne 0 ]; then
			echo_stderr "callback \"$callback\" returned $return_value for \"$entry\""
			return $return_value
		fi
	done
}

# Verify that target_file is reasonably safe to remove.
# target_file is considered safe when no file exists at that path or it is a
# symbolic link.
#
# Parameters:
#   source_file - filepath
#   target_file - filepath
# Returns:
#   0 if target_file is save to remove, 1 target_file is either a regular file
#   or a directory.
function verify_target_file_is_safe_to_remove() {
	local source_file=$1 target_file=$2
	if [ ! -e "$target_file" ]; then
		return 0
	elif [ -L "$target_file" ]; then
		return 0
	elif [ -f "$target_file" ] || [ -d "$target_file" ]; then
		echo_stderr "removing $target_file is unsafe and may cause data loss"
		return 1
	fi
}

# rm target_file.
#
# Parameters:
#   source_file - filepath
#   target_file - filepath
# Returns:
#   0 if target_file is removed, non-zero otherwise.
function rm_target_file() {
	local source_file=$1 target_file=$2
	rm -rfv "$target_file"
}

# Symbolically link source_file and target_file.
#
# Parameters:
#   source_file - filepath
#   target_file - filepath
# Returns:
#   0 if source_file and target_file are symbolically linked, non-zero
#   otherwise.
function create_symbolic_links() {
	local source_file=$1 target_file=$2
	ln -sfv "$source_file" "$target_file"
}

echo "Looking for pre-existing dotfiles/configurations"
if ! for_each_linked_file verify_target_file_is_safe_to_remove; then
	exit 1
fi

echo "Removing lingering dotfiles/configurations"
if ! for_each_linked_file rm_target_file; then
	exit 1
fi

echo "Creating symbolic links"
if ! for_each_linked_file create_symbolic_links; then
	exit 1
fi

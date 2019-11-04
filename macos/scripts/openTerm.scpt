#!/usr/bin/env osascript
-- vim: ft=applescript

-- https://apple.stackexchange.com/a/359874
on count_windows_on_current_space(process_name)
	tell application "System Events"
		tell process process_name
			return count of windows
		end tell
	end tell
end count_windows_on_current_space

(*

current functionality:
creates new windows, unless desktop has 3 or more iterms, then it makes tabs

wanted functionality:
if there are less than x number of terminal sessions open already, switch me over
to the pre-existing terminal sessoin

*)

if application "iTerm2" is running or application "iTerm" is running then
	tell application "iTerm"
		if my count_windows_on_current_space("iTerm2") <= 2 then
			create window with default profile
		else
			tell the first window
				create tab with default profile
			end tell
		end if
	end tell
else
	tell application "iTerm"
		activate
		try
			select first window
		on error
			create window with default profile
			select first window
		end try
	end tell
end if

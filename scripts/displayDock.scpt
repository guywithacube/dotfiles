#!/usr/bin/env osascript

-- https://www.organizingcreativity.com/2017/08/mac-tip-moving-and-auto-hiding-the-dock-if-you-work-with-different-screen-setups/
tell application "System Events"
	
	set displayCount to count of desktops
	-- https://apple.stackexchange.com/q/228039
	(* consider looking into more in depth set-up checking:
	    - monitor dimensions
	    - monitor manufactor
	   https://apple.stackexchange.com/a/303629
	*)
	
	tell dock preferences
		set dockLocation to screen edge
		
		-- autohide https://stackoverflow.com/a/14442136
		if displayCount = 1 then
			set autohide to true
		else
			set autohide to false
		end if
		
		if displayCount ≥ 3 then
			if dockLocation is right then
				set properties to {screen edge:bottom}
			end if
		else
			if dockLocation is bottom then
				set properties to {screen edge:right}
			end if
		end if
		
	end tell
end tell


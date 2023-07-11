set includeSubFolders to true
set theDateNameSeparator to "_"
set theDateSeparator to "-"




--------------------------------------------------------------------------------------------------
tell application "Finder"
	set theFolder to ((choose folder with prompt "Kindly Choose Folder") as string)
	
	if includeSubFolders then
		set theFiles to every file of entire contents of folder theFolder
	else
		set theFiles to every file of folder theFolder
	end if
	
	
	repeat with theFile in theFiles
		set fileName to do shell script "basename " & quoted form of POSIX path of (theFile as string) & " | cut -d '.' -f 1"
		set theExt to ("." & name extension of theFile) as string
		set {year:y, month:m, day:d} to (get modification date of theFile)
		set day_str to text -1 thru -2 of ("00" & d)
		set mon_str to text -1 thru -2 of ("00" & (m * 1))
		set theDate to (y & theDateSeparator & mon_str & theDateSeparator & day_str) as string
		set newName to (fileName & theDateNameSeparator & theDate & theExt)
		set name of theFile to newName
	end repeat
	
end tell
--------------------------------------------------------------------------------------------------

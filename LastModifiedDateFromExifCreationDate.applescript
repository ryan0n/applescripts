tell application "Finder"
	set theFileList to every file of folder POSIX file "/Users/ryanw/Google Drive/Google Photos/2017/" as alias list
end tell
repeat with theFile in theFileList
	try
		tell application "Image Events"
			set theOpenFile to open theFile
			tell theOpenFile
				set theTag to metadata tag "creation"
			end tell
			set theTagValue to value of theTag
			set myArray to my theSplit(theTagValue, " ")
			set fileDate to myArray's item 1
			set fileDate to my replaceText(":", "", fileDate)
			set fileTime to myArray's item 2
			set fileTime to my replaceText(":", "", fileTime)
			set fileDateTime to fileDate & fileTime
			set fileDateTime to text 1 thru 12 of fileDateTime
			close theOpenFile
		end tell
		set fileName to POSIX path of theFile
		set shellcommand to "touch -t " & fileDateTime & space & "'" & fileName & "'"
		log shellcommand
		do shell script shellcommand
	on error error_message number error_number
		log error_message & space & "Consult reference number error_number & then try again!"
	end try
end repeat

on theSplit(theString, theDelimiter)
	-- save delimiters to restore old settings
	set oldDelimiters to AppleScript's text item delimiters
	-- set delimiters to delimiter to be used
	set AppleScript's text item delimiters to theDelimiter
	-- create the array
	set theArray to every text item of theString
	-- restore the old setting
	set AppleScript's text item delimiters to oldDelimiters
	-- return the result
	return theArray
end theSplit

on replaceText(find, replace, subject)
	set prevTIDs to text item delimiters of AppleScript
	set text item delimiters of AppleScript to find
	set subject to text items of subject
	
	set text item delimiters of AppleScript to replace
	set subject to subject as text
	set text item delimiters of AppleScript to prevTIDs
	
	return subject
end replaceText
# applescripts
Misc AppleScripts

<strong>LastModifiedDateFromExifCreationDate.applescript</strong><br>
Loops through files in a directory and tries to get the "creation" meta data from exif data in the file. If the creation data exists, it will use touch -t to set the file's last modified date to the exif creation date. This is useful 

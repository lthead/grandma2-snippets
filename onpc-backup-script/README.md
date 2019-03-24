# MA2 onPC Show Folder Backup Script
This Windows Powershell script will allow you to create backups of your entire showfolder on an external drive or your cloud storage (e.g. Google Drive, Dropbox, etc.).

This closes the gap that the missing support for FTP backups in onPC systems left us with.

# How to use
Adapt `$source`, `$dest` and `$archiveFormat` to your needs, and then execute the script by double clicking on it.

# Trouble shooting ("executon of scripts is disabled")
In case you get the error message `“execution of scripts is disabled on this system.”`, [try this solution from StackOverflow](https://stackoverflow.com/questions/4037939/powershell-says-execution-of-scripts-is-disabled-on-this-system).

In case of Windows 8.1 and earlier update of PowerShell may be necessary: https://www.microsoft.com/en-us/download/details.aspx?id=54616

# Additional

If you don't have 7-zip installed please consider to install it (it is much faster, highly reliable and uses all cores).

If you don't want to use 7-zip you have nothing to do - just be sure you are using at least PowerShell 5 to run Compress-Archive command. 


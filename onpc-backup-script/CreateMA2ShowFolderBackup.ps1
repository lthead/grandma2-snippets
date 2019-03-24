<#
        Original Version by: Philipp Börner
        Source: https://freshblog.azurewebsites.net/2016/03/28/backup-you-work-with-powershell/
        Adapted by @aGuyNamedJonas for MA2 onPC
        
        Modified by Michał Głowienko
        Inspired by:
        morgb >>> https://stackoverflow.com/questions/39253435/renaming-a-file-name-to-the-next-incremental-number-with-powershell-script/39254176
        DarkLite1 >>> https://stackoverflow.com/questions/25287994/running-7-zip-from-within-a-powershell-script
        ---------------------------------------------
        SUBSCRIBE      >>> youtube.com/aGuyNamedJonas
        QA & COMMUNITY >>> fb.com/aGuyNamedJonas
        GET IN TOUCH   >>> hi@aGuyNamedJonas.com
        ---------------------------------------------
        HOW TO USE:
        - Make sure $source points to your PC's showfolder
        - Change $dest to point to your harddrive / cloud storage folder (=backup folder)
        - Choose $archiveFormat, ".7z" is recommended, but you can use also ".zip", ".tar" and others.
#>

#Define source and destination folders
$source = "$env:ProgramData\MA Lighting Technologies\grandma"
$dest = "D:\onPC Backup Folder"
$archiveFormat = ".7z"

#Getting the current date
$date = Get-Date -UFormat _%Y_%m_%d

#Building archive file name and complete backup path
$ZipFile = "MAShowFolderBackup" + $date
$BackupPath = $dest + "\" + $ZipFile + $archiveFormat

#Checking if file name exist. If yes - add a number after "-"
function AddRevisionNumber([string]$BackupPath)
{
    if (Test-Path $BackupPath)
    {
        $latest = Get-ChildItem -Path $dest| Sort-Object Name -Descending | Select-Object -First 1
        #split the latest filename, increment the number, then re-assemble new filename:
        $newFileName = $latest.BaseName.Split("-")[0] + "-" + ([int]$latest.BaseName.Split("-")[1] + 1).ToString().PadLeft(3,"0") + $latest.Extension
        Move-Item -path $BackupPath -destination $dest\$newFileName
    }
}

#Creating archive with 7-zip if it is installed. If it is not - try to use Compress-Archive method and change to .zip extension.
if (test-path "$env:ProgramFiles\7-Zip\7z.exe")
{
        AddRevisionNumber $BackupPath
        set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"
        sz a -mx=9 $BackupPath $source
}
elseif (test-path "${env:ProgramFiles(x86)}\7-Zip\7z.exe")
{
        AddRevisionNumber $BackupPath
        set-alias sz "${env:ProgramFiles(x86)}\7-Zip\7z.exe"
        sz a -mx=9 $BackupPath $source
}
else
{
        $BackupPath = $dest + "\" + $ZipFile + ".zip"
        AddRevisionNumber $BackupPath
        Get-Item -Path $source | Compress-Archive -DestinationPath $BackupPath -CompressionLevel Optimal -Verbose
}

#Troubleshooting - PowerShell should not close after error
Read-Host `n`n"PRESS ENTER TO CONTINUE..."

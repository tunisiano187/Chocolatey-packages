$ErrorActionPreference = 'Stop'
$url            = 'https://www.wagnardsoft.com/DDU/download/DDU%20v18.0.6.0.exe'
$checksum       = '48ebdaf2e7a2ede56e91e0800f8a1128f0e8883e4d9feb3d46808d8218dfe8fc'
$checksumType   = 'sha256'
$referer        = 'https://www.wagnardsoft.com/forums/viewtopic.php?t=4316&sid=881b0a7a62fd98d625b0dd0bc4358350'

Invoke-WebRequest -Uri $referer -OutFile "$env:TEMP/test.html" #  Required to be allowed just after

$packageArgs		        = @{
    UnzipLocation	          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
	packageName		          = $env:ChocolateyPackageName
	url				          = $url
	checksum		          = $checksum
	fileType                  = 'exe'
	checksumType              = $checksumType
	silentArgs                = '/s'
}

Remove-Item "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\*.exe"
Remove-Item "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\DDU*" -Recurse

Install-ChocolateyZipPackage @packageArgs
$toshort=(Get-ChildItem -Folder $(Split-Path -parent $MyInvocation.MyCommand.Definition) -Recurse -Include *uninstaller.exe).FullName

$link=join-path $env:ProgramData "Microsoft/Windows/Start Menu/Programs/"
$link = Join-Path $link "DisplayDriverUninstaller.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $link -TargetPath $toshort -PinToTaskbar

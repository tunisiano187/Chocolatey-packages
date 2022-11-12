$ErrorActionPreference = 'Stop'
$url            = 'https://www.wagnardsoft.com/DDU/download/DDU%20v18.0.5.8.exe'
$checksum       = '6e4e49ac2c3f2281fcb929eeebc27e2ce2860802357c9ec879bbd8f37bc4e1c7'
$checksumType   = 'sha256'
$referer        = 'https://www.wagnardsoft.com/forums/viewtopic.php?t=4194&sid=0d4468eec9f2382fd0862663fdb42ac5'

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

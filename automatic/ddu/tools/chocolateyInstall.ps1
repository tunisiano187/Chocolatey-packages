$ErrorActionPreference = 'Stop'
$url            = 'https://www.wagnardsoft.com/DDU/download/DDU%20v18.0.3.9.exe'
$checksum       = 'c5798bb2dbf908fae8e84c9e4c0c9e5c9ee49d1a9e5fff0eed6cb0c26f1db3f8'
$checksumType   = 'sha256'
$referer        = 'https://www.wagnardsoft.com/forums/viewtopic.php?f=5&t=3480'

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
Get-ChildItem -Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) -Directory -Exclude "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\tools"

Install-ChocolateyZipPackage @packageArgs

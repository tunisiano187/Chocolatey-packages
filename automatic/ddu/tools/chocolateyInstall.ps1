$ErrorActionPreference = 'Stop'
$url            = 'https://www.wagnardsoft.com/DDU/download/DDU%20v18.0.4.1.exe'
$checksum       = '4193cdfd6f87341124c50a7d1d61ab07a8be284ec99096e9321bcfe6d3b42bbb'
$checksumType   = 'sha256'
$referer        = 'https://www.wagnardsoft.com/forums/viewtopic.php?f=5&t=3517'

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

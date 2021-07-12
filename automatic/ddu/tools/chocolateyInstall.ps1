$ErrorActionPreference = 'Stop'
$url            = 'https://www.wagnardsoft.com/DDU/download/DDU%20v18.0.4.2.exe'
$checksum       = 'b374bccf426cf23f02c5c387cd66b1e89a3c5be37a1eb3c42c1e4e9a55ec05ca'
$checksumType   = 'sha256'
$referer        = 'https://www.wagnardsoft.com/forums/viewtopic.php?f=5&t=3576'

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

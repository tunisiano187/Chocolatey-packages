$ErrorActionPreference = 'Stop'
$url            = 'https://www.wagnardsoft.com/ISLC/ISLC%20v1.0.3.2.exe'
$checksum       = 'fc4961d4ffa095eb150b29ceb9d26a77098988c6549fe6187dbb80bfa2a6a381'
$checksumType   = 'sha256'
$referer        = 'https://www.wagnardsoft.com/forums/viewtopic.php?t=1256&sid=8f9b7672c7f1a01393715331717d96d2'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

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
Remove-Item "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\ISLC*" -Recurse

Install-ChocolateyZipPackage @packageArgs

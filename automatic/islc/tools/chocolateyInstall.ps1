$ErrorActionPreference = 'Stop'
$url            = 'https://www.wagnardsoft.com/ISLC/ISLC%20v1.0.3.3.exe'
$checksum       = '331bf280ee3f8ba09b6ecc712a8c36ac806fb9e0701700d3f94fbeac7ff78d0d'
$checksumType   = 'sha256'
$referer        = 'https://www.wagnardsoft.com/forums/viewtopic.php?t=1256&sid=425fed01d6b929ea647373b7fe59c313'
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

$ErrorActionPreference = 'Stop'
$url            = 'https://www.wagnardsoft.com/DDU/download/DDU%20v18.1.3.9.exe'
$checksum       = '7c52e7bbbef3a32c1117c1ef402b96765d2d770a8a0c0dcc2f5af5c11c89ab07'
$checksumType   = 'sha256'
$referer        = 'https://www.wagnardsoft.com/forums/viewtopic.php?t=5455&sid=ec81066e4c722d3bbc51d095fefa4c1a'
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
Remove-Item "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\DDU*" -Recurse

Install-ChocolateyZipPackage @packageArgs

$ErrorActionPreference = 'Stop'
$url            = 'https://www.wagnardsoft.com/DDU/download/DDU%20v18.0.7.7.exe'
$checksum       = '859aba702b90003b5cb9ff3c070dc90fd467e14a656bf439cccb6e43695108b7'
$checksumType   = 'sha256'
$referer        = 'https://www.wagnardsoft.com/forums/viewtopic.php?t=4949&sid=f02203418852325604ac44f5a683035d'
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

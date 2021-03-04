$ErrorActionPreference = 'Stop'
$url            = 'https://www.wagnardsoft.com/DDU/download/DDU%20v18.0.3.7.exe'
$checksum       = '68939586dae223c07469b9267a5369c1837657acf454db47651bd3dd3b8dc060'
$checksumType   = 'sha256'
$referer        = 'https://www.wagnardsoft.com/forums/viewtopic.php?f=5&t=3450'

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

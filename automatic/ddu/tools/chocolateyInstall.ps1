$ErrorActionPreference = 'Stop'
$url            = 'https://www.wagnardsoft.com/DDU/download/DDU%20v18.0.4.9.exe'
$checksum       = '12945e66e1a3bf16d718d0cc186a08e984b77d477bf2424b3590e082b14c6149'
$checksumType   = 'sha256'
$referer        = 'https://www.wagnardsoft.com/forums/viewtopic.php?t=3915&sid=078351ea5bdd8b8e765df6f8f26e945b'

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

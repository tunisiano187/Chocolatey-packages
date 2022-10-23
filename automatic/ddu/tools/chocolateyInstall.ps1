$ErrorActionPreference = 'Stop'
$url            = 'https://www.wagnardsoft.com/DDU/download/DDU%20v18.0.5.6.exe'
$checksum       = 'cc726d20dfd72678c273bc7c927eb626e1f5b3e814c0f5378cd6582eca2253ba'
$checksumType   = 'sha256'
$referer        = 'https://www.wagnardsoft.com/forums/viewtopic.php?t=4171&sid=41a8bc8ec90d199fab53e18d83e92abe'

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

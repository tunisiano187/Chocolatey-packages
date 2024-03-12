$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$url = 'http://prdownloads.sourceforge.net/jacksum/jacksum-1.7.0.zip?download'
$toolsDir = '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'
$checksum = 'e3d840fa7b9949003ca731c7ce3e0281c350d821'
$checksumType = 'sha1'

$packageArgs = @{
	packageName   = $env:ChocolateyPackageName
	unzipLocation = $toolsDir
	url           = $url
	checksum      = $checksum
	checksumType  = $checksumType
  }


Install-ChocolateyZipPackage @packageArgs

$file = (Get-ChildItem -Path $toolsDir -Include "*.exe" -Recurse).FullName

$packageArgs = @{
	packageName   = $env:ChocolateyPackageName
	fileType      = 'EXE'
	file          = $file
	softwareName  = 'Jacksum*'
	silentArgs   = '/S'
}

Install-ChocolateyInstallPackage @packageArgs
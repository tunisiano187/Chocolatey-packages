$ErrorActionPreference = 'Stop';

$url              = 'https://www.apple.com/itunes/download/win32'
$checksum         = 'cd6891afada9f940bc551a215a6c40f51a93b140026375bd30b1ee686dc73bd2'
$checksumType     = 'SHA256'

$url64            = 'https://www.apple.com/itunes/download/win64'
$checksum64       = '541c30b2d72705afe75649f97e3daf677b8576e6e73d6f78f7265a0ded61011f'
$checksumType64   = 'SHA256'

$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath     = "$toolsDir\itunes.zip"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  FileFullPath  = $fileFullPath

  url           = $url
  Checksum      = $checksum
  checksumType  = $checksumType

  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= $checksumType64

}

Get-ChocolateyWebFile @packageArgs
Get-ChocolateyUnzip -fileFullPath $fileFullPath -destination $toolsDir

$bonjour = (Get-ChildItem -Path $toolsDir -Filter "Bonjour*.msi").FullName

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType		  = "msi"

  file          = $bonjour

  silentArgs	= "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-ChocolateyPackage @packageArgs

$ErrorActionPreference = 'Stop'
$packageName    = 'ost2'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://d.4team.biz/files/ost2_setup.exe'
$checksum       = '52E3584C03AA22494862C0C8EBE34C18CDE91646665977ACCD9E598F868C6C19'
$checksumType   = 'sha256'
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\OST2install.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  checksum       = $checksum
  checksumType   = $checksumType
  silentArgs     = '/S'
  validExitCodes = @(0,2)
  softwareName   = 'OST2*'
  }

Install-ChocolateyPackage @packageArgs

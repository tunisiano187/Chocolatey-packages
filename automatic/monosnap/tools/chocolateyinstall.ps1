$ErrorActionPreference = 'Stop';
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$url          = 'https://static.monosnap.com/windows/MonosnapSetup.exe'
$checksum     = '2331279833e97ac40ad10a14cd2ee73da2ad2e106566b25c26b8a168a4d0f77e'
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = 'monosnap'
  fileType       = 'exe'
  url            = $url
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'monosnap*'
  checksum       = $checksum
  checksumType   = $checksumType
  toolsDir       = $toolsDir
}

Start-Process "$toolsDir\stop-process.ps1"

Install-ChocolateyPackage @packageArgs
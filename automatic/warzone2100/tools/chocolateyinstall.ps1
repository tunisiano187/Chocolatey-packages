$ErrorActionPreference = 'Stop'
$packageName  = 'warzone2100'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32        = 'https://github.com/Warzone2100/warzone2100/releases/download/4.5.1/warzone2100_win_x86_installer.exe'
$checksum32   = '8d86be237857c76fe6212e7be0f6a7dd93163f285401391cc6258818ca44b9d7'
$url64        = 'https://github.com/Warzone2100/warzone2100/releases/download/4.5.1/warzone2100_win_x64_installer.exe'
$checksum64   = 'e5b4a7b201973b750b0b30c4b3fa96a623b185745763709eff8b1a930b91ab1e'
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url32
  url64bit       = $url64
  validExitCodes = @(0)
  silentArgs     = '/S'
  softwareName   = 'Warzone 2100*'
  checksum       = $checksum32
  checksumType   = $checksumType
  checksum64     = $checksum64
  checksumType64 = $checksumType
}

Install-ChocolateyPackage @packageArgs

Remove-Item $toolsDir\*.exe -EA SilentlyContinue | Out-Null

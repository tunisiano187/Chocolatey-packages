$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64          = 'https://proton.me/download/pass/windows/ProtonPass_Setup_1.36.1.exe'
$checksum64     = '36F3327ED641E6E4224D01A3818DA7044824BFF85410F1CCD801520BC35E2E36'
$checksumType64 = 'sha256'

if ((Get-IsWinServer)) {
  Write-Warning "  ** This package is for Windows Workstation OSes only. Aborting."
  throw
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64bit      = $url64
  silentArgs    = "/s"
  validExitCodes= @(0)
  softwareName  = 'Proton Pass*'
  checksum64    = $checksum64
  checksumType64= $checksumType64
}

Install-ChocolateyPackage @packageArgs

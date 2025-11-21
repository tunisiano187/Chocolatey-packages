$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64          = 'https://proton.me/download/pass/windows/ProtonPass_Setup_1.33.0.exe'
$checksum64     = 'F7C4D078AFC0691389092F0C94BE55672935958CF0743335A824F7876151ED5C'
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

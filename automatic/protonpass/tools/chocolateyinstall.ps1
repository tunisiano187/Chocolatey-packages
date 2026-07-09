$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64          = 'https://proton.me/download/pass/windows/ProtonPass_1.38.1.msix'
$checksum64     = '5C13C608CC4E9BCF9265792E4B92E836AF93D2BD8186E7AC1FAD677A7BBFAE2B'
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

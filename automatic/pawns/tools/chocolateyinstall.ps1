$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64          = 'https://cdn.pawns.app/download/app/latest/windows/Pawns%20Setup.exe'
$checksum64     = 'd9a36349cc242dbe95afc1731564cfc203a3882c8920613c681275862232ba95'
$checksumType64 = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64bit      = $url64

  softwareName  = 'pawns*'

  checksum64    = $Checksum64
  checksumType64= $ChecksumType64

  # MSI
  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

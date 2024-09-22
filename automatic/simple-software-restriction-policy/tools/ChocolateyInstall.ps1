$ErrorActionPreference = 'Stop'
$packageName = 'simple-software-restriction-policy'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\SoftwarePolicy220Setup.exe"
$checksum    = 'A5D6A2D8CE5F8F80D7CAA54509B8BB30C8483002FC6D7A084391F14C89C92F0A'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName  = 'Software Policy*'
}

Install-ChocolateyPackage @packageArgs
Remove-Item $toolsDir\*.exe -Force | Out-Null

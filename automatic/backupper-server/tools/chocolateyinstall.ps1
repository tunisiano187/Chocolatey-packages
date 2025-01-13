$ErrorActionPreference = 'Stop'
$packageName    = 'backupper-server'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.ubackup.com/ss/download/adb/ABServerTrial.exe'
$checksum       = '6FBF2584EDC187EFCAF845874D22406D1990BBEE6100F8F17EB62A7DFA57B78A'
$checksumType   = 'sha256'

if (!(Get-IsWinServer)) {
    Write-Warning "  ** This package is for Windows Server OSes only. Aborting."
    throw
}

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'AOMEI Backupper Server*'
  checksum      = $checksum
  checksumType  = $checksumType
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0,1)
}

Install-ChocolateyPackage @packageArgs

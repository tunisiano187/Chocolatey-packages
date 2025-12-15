$ErrorActionPreference = 'Stop'
$packageName    = 'backupper-server'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www2.aomeisoftware.com/download/adb/ABServerTrial.exe'
$checksum       = 'FCA81EC6930922351FB98C429D76164A0D82152F9BBE5D2E92F500CA83C43352'
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

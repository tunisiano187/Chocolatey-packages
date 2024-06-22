$ErrorActionPreference = 'Stop'
$packageName    = 'backupper-server'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.ubackup.com/ss/download/adb/ABServerTrial.exe'
$checksum       = '1AF99FF249FEC1715B07B8049A59402457F11918541F6451FD20397F6E8349BF'
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

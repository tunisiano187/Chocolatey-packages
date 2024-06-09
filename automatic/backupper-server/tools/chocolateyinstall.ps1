$ErrorActionPreference = 'Stop'
$packageName    = 'backupper-server'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www2.aomeisoftware.com/download/adb/ABServer.exe'
$checksum       = '8E98F3979DAEC0B834DC0426A7DBF4581F13D7058112EAAB1E27AF3DFF8BA03D'

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
  checksumType  = 'sha256'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0,1)
  }

Install-ChocolateyPackage @packageArgs

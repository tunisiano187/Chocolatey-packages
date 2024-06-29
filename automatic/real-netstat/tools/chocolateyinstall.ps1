$ErrorActionPreference = 'Stop'

$packageName= 'real-netstat'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://netstatagent.com/files/realnetstat-setup.exe'
$url64      = 'http://netstatagent.com/files/realnetstat-setup.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64
  softwareName  = 'Real NetStat*'
  checksum      = '1F3A8BE20447853D0403062BD038FDA4FEFA277BE83575A7AD5D608AB1702077'
  checksumType  = 'sha256'
  checksum64    = '1F3A8BE20447853D0403062BD038FDA4FEFA277BE83575A7AD5D608AB1702077'
  checksumType64= 'sha256'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

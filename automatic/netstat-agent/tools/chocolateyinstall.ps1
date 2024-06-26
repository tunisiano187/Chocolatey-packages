$ErrorActionPreference = 'Stop'
$packageName= 'netstat-agent' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://netstatagent.com/files/netagent-setup.exe' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'NetStat Agent*' 
  checksum      = 'D6AF04B6315BD5FA6E4F434F32EA228B9F6C699BB9104E9D64AEBC9EC38D39CA'
  checksumType  = 'sha256'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

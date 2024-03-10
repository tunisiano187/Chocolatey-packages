$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://down.easeus.com/product/tb_free?ref=/backup-software/tb-free.html'

$packageArgs = @{
  packageName   = 'todobackup'
  fileType      = 'exe'
  url           = $url
  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  softwareName  = 'todobackup'
  checksum      = 'C892D1FC4A91135D220851BE47D472B964C09F46336F73FFF2A30A1B5D8D36DC'
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs 
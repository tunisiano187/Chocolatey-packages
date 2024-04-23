$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = "http://www.acarda.com/downloads/acardaoutbound/AcardaOutboundSoloSetup-7.4.0.2988.exe"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'Acarda Outbound Solo Editon'

  checksum      = 'A45D2FDBA7B963C5808633A9FF87A02451D637FC4F85B1AA99B16DF80B16070C'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

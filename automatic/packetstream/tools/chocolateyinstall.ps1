$ErrorActionPreference = 'Stop'
$url			      = 'https://s3-us-west-2.amazonaws.com/packetstream-releases/latest/PacketStream.exe'
$checksum		    = 'c36e76b321505a4ef1660d558a08ac572ce7cfd35f256801e1d4cfc765a75998'
$checksumtype   = 'sha256'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = $url
  silentArgs    = '/quiet'
  validExitCodes= @(0,3010)
  softwareName  = 'Packetstream*'
  checksum      = $checksum
  checksumType  = $checksumtype
}

Install-ChocolateyPackage @packageArgs

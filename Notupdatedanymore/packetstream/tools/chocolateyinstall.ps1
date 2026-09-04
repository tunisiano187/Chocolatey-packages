$ErrorActionPreference = 'Stop'
$url			      = 'https://s3-us-west-2.amazonaws.com/packetstream-releases/latest/PacketStream.exe'
$checksum		    = '32be582b29acb91e8e8885cd8680c94d375ca7748c22b51645688747e4199429'
$checksumtype   = 'sha256'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = $url
  silentArgs    = '/S'
  validExitCodes= @(0,3010)
  softwareName  = 'Packetstream*'
  checksum      = $checksum
  checksumType  = $checksumtype
}

Install-ChocolateyPackage @packageArgs

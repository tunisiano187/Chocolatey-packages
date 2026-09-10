$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://github.com/pi-node/pi-node/releases/download/0.6.3/Pi.Network.Setup.0.6.3.exe'
$checksum         = '083d90eb4a3d389458fd42c961e2650dc9be81995382864fb4a4548b3004fb89'
$checksumType     = 'sha256'

$packageArgs = @{
  packageName     = $packageName
  unzipLocation   = $toolsDir
  fileType        = 'EXE'
  url             = $url

  softwareName    = 'Pi Network*'

  checksum        = $checksum
  checksumType    = $checksumType

  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs

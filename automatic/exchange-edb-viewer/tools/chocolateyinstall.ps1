$packageName = 'exchange-edb-viewer'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://www.nucleustechnologies.com/downloads/exchange-edb-viewer.exe'
$checksum    = 'F09E131EFE586754BA41550179C793BE39A0EFECF697A14D875ABD9685D2F8E8'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName  = 'Kernel Exchange EDB Viewer*'
  checksum      = $checksum
  checksumType  = 'sha256'
  }

Install-ChocolateyPackage @packageArgs


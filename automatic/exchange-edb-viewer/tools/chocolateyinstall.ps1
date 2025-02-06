$packageName = 'exchange-edb-viewer'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://www.nucleustechnologies.com/downloads/exchange-edb-viewer.exe'
$checksum    = '465BC1041EE2C5082F2E26A38B1B61C587423B4D2F032B5BE38CE7D574ADE3ED'

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


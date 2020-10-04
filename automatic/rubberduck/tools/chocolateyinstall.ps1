$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/rubberduck-vba/Rubberduck/releases/download/Prerelease-v2.5.1.5585/Rubberduck.Setup.2.5.1.5585-pre.exe' # download url
$checksum     = '41552ad7d30091329a38fdfe0ab69a86b9ac37093c7fee98bca7c3f530d20f2a'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
  silentArgs    = "/VERYSILENT"
}

Install-ChocolateyPackage @packageArgs

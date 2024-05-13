
$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://nightly.kvirc.net/win-x86_64/KVIrc-5.2.4-dev-2024-05-12-git-04f93ac.exe'
$checksum       = '02f3564655fb7528592fe8c6c81bf0802561e32340ee0d7ba85af908b88820e1'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'KVIrc*'
  checksum      = $checksum
  checksumType  = $checksumType
  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs

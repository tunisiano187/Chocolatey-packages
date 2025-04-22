$ErrorActionPreference = 'Stop'
$url			= 'https://dba0rg1h0v09q.cloudfront.net/odrivesync.7364.exe'
$checksum		= 'f5d20752b18be867dee0347e2352247a76e320766ce0c7d4ac9f278bb2570ad0'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = $url
  silentArgs    = '/quiet'
  validExitCodes= @(0,3010)
  softwareName  = 'odrive*'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs

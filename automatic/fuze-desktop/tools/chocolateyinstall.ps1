﻿$ErrorActionPreference = 'Stop'

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://d1yyftelocodol.cloudfront.net/windows/23.11.14510/FuzeInstallerPerMachine.exe'
$checksum     = 'ed336beb1e21c87900fda866d471e8d944916689c3e1d623e52d687e34449799'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'fuze*'

  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
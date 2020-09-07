﻿$toolsDir     = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url          = 'https://www.mobatek.net/exes/MobaLiveCD_v2.1.exe'
$checksum     = 'ddb4adf5dff5656673bf90e37ff397cb0736c68225ae8f4d17ee17f83c723994'
$checksumType = 'sha256'

try {
  #Install-ChocolateyPackage 'mobalivecd' 'EXE' '/SILENT' "$downUrl" -validExitCodes @(0)

  $packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    url             = $url
    checksum        = $checksum
    checksumType    = $checksumType
    FileFullPath    = "${toolsDir}\MobaLiveCD_v2.1.exe"
  }

  Get-ChocolateyWebFile @packageArgs
  Install-ChocolateyDesktopLink "${toolsDir}\MobaLiveCD_v2.1.exe"
} catch {
  throw "$($_.Exception.Message)"
}

﻿$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = $toolsdir
$version    = '2.2.3'

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    FileFullPath    = "$toolsDir\redshift-tray.zip"
    Destination     = "$installDir"
}

Get-ChocolateyUnzip @packageArgs

#Write-Debug "Installing $version"
#Install-BinFile "rstray" "$installDir\rstray.exe"

#Remove-Item $toolsDir\*.zip -ea 0

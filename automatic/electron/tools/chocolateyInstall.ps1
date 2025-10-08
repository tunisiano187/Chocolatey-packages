$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v38.2.2/electron-v38.2.2-win32-ia32.zip'
$checksum = '07798457f520be6adeb96d9cff88ae4ed642adf9dc91c6b76bce4f3a98ec72d7'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v38.2.2/electron-v38.2.2-win32-x64.zip'
$checksum64 = 'af5230d3f698cb50fce18805a3fd584e06836c61e72b6e0fd90d410b719f24dc'
$checksumType64 = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Url64bit "$url64" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType" `
                             -Checksum64 "$checksum64" `
                             -ChecksumType64 "$checksumType64"

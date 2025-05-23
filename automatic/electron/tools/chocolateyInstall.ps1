$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v36.3.1/electron-v36.3.1-win32-ia32.zip'
$checksum = '6de5f8e916e05ff4405f835c78a80a50f8ee732555162b79b4f13f692a31ad95'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v36.3.1/electron-v36.3.1-win32-x64.zip'
$checksum64 = '6729f807c58d65d210df956702d2bacdd22cc33fb9e6020348becb606187ab99'
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

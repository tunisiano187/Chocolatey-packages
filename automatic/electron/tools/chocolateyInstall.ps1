$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v36.2.1/electron-v36.2.1-win32-ia32.zip'
$checksum = '6830bba659898ab6bf061962c9fe07b27b55c7c1b5a6a066e1448057eef0dca8'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v36.2.1/electron-v36.2.1-win32-x64.zip'
$checksum64 = '62c9e409bf70507625807d694cd61b4a045136bcdc4f2a1c54c6d49332d46e15'
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

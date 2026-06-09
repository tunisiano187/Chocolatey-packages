$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v42.4.0/electron-v42.4.0-win32-ia32.zip'
$checksum = '06c1cd7d72c0b645de602a9ec8a812552747c96152df8023d6f0c567dbdd2a37'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v42.4.0/electron-v42.4.0-win32-x64.zip'
$checksum64 = 'ffc056685b4a769d7977ef3d58bdc332446d081f025ee074d77b498d2962e2cd'
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

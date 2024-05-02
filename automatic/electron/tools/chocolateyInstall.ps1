$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v30.0.2/electron-v30.0.2-win32-ia32.zip'
$checksum = '4d2ea48fe1bea934a3fab0b15433c8fbec5cd7da3d28ed3c76ed5b57a7ffb690'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v30.0.2/electron-v30.0.2-win32-x64.zip'
$checksum64 = '8541f3a92f6fd55a92ec903a16eebdd085d9b87ea06a690a4f3912d32febc565'
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

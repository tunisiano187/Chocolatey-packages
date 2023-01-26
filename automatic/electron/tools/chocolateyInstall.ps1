$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v22.1.0/electron-v22.1.0-win32-ia32.zip'
$checksum = 'f989792be95c62404a7b7afa6b940e2b8b50f1b76e4c69a88426d5b6d334a9f1'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v22.1.0/electron-v22.1.0-win32-x64.zip'
$checksum64 = 'f0e54799cc8de8379fff32bf3d47b4ae52ad04ec681c74d143d689c4047e091f'
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

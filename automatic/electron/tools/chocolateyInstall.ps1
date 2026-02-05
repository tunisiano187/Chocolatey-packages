$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v40.2.0/electron-v40.2.0-win32-ia32.zip'
$checksum = 'b5fda0cd0115e05348620d3b3082f09cacf3a07f5466e77b7c21643671aca1f1'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v40.2.0/electron-v40.2.0-win32-x64.zip'
$checksum64 = '3d5fd7fdb7caea1d933355a3d47d958c49ff728480d5df763d8fda5699a19954'
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

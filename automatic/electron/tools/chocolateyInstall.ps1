$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v32.1.1/electron-v32.1.1-win32-ia32.zip'
$checksum = 'b91d4449a188ce69e5eda831feecec4f9837a32aec4dec540731a8f6bb1b7834'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v32.1.1/electron-v32.1.1-win32-x64.zip'
$checksum64 = 'ce32b239271edd725e2f53a95d65a3a01df228289d94dfefdb749eb8991af3ce'
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

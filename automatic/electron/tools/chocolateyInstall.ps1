$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v29.0.1/electron-v29.0.1-win32-ia32.zip'
$checksum = 'e8eaf5b17be50b96477bed3f6f649a19db21144c7687a8122f6d326403240e78'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v29.0.1/electron-v29.0.1-win32-x64.zip'
$checksum64 = '627b10603c3d50f3bae86c1ce7152b2d3ef9f579b2722cdcc1185829ed9ef13d'
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

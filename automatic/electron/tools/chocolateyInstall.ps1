$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v32.1.0/electron-v32.1.0-win32-ia32.zip'
$checksum = '23cbecd7114a69a507ab27659d904e2ea3a3c2a82ac65a9635af89dec2a0544f'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v32.1.0/electron-v32.1.0-win32-x64.zip'
$checksum64 = 'af31750386553869fd8ec0ad65e75621d2426443a51282b19ec3c4f5e80ae607'
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

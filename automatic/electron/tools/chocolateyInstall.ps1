$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v37.2.4/electron-v37.2.4-win32-ia32.zip'
$checksum = '1ae362803f875f092273b20d1046651a7b95474e6c781ad78b03501f329e71f6'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v37.2.4/electron-v37.2.4-win32-x64.zip'
$checksum64 = '48d228f7b1e019a51f0e4152103e804824d90bfbbc14de35fe33caa5dc45991f'
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

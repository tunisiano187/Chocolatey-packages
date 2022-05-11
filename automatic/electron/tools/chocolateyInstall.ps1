$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v18.2.2/electron-v18.2.2-win32-ia32.zip'
$checksum = '6c47b242adf8e38315a7681ca13bd230b89be3e5c91867386cb8fdf936148d37'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v18.2.2/electron-v18.2.2-win32-x64.zip'
$checksum64 = '0303279952c51e5d0aeeb00a9c415ecc1133c7c13456241d16442c6d26998e57'
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

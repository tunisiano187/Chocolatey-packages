$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v35.0.2/electron-v35.0.2-win32-ia32.zip'
$checksum = 'd830e90c0b60f7e86d16470ad90117515b0211d564e050c66ede6f48fbc47d48'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v35.0.2/electron-v35.0.2-win32-x64.zip'
$checksum64 = 'e0f208a3ddeedcb2fedbe375e7d670be13ca6d1f04f83213daa120a18003a98d'
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

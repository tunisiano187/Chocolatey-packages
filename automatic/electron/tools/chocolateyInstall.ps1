$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v18.2.3/electron-v18.2.3-win32-ia32.zip'
$checksum = '8edf1396f3c3d333acf80d11f20d1850d391a289f6400014ed2e150f1f2de201'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v18.2.3/electron-v18.2.3-win32-x64.zip'
$checksum64 = '7989917d4b69186322f46d9c160441dbe1492d6f3c6bc091288fbce003098cea'
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

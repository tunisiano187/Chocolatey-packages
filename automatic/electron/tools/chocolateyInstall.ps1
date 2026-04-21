$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v41.2.2/electron-v41.2.2-win32-ia32.zip'
$checksum = '4557bd30fd4f96efb53605bc055be0c5f83b77b22626f74994432b0847c53afe'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v41.2.2/electron-v41.2.2-win32-x64.zip'
$checksum64 = '2a710a4e8cfbbb2cf46abb56c35bf38f98d53db332f4006870c6338a825325a0'
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

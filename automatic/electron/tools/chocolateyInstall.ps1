$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v25.1.1/electron-v25.1.1-win32-ia32.zip'
$checksum = '91ef685c156134b5ed8b136ffa39ecbf257dcbd387a32f621c57f4151d65ca89'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v25.1.1/electron-v25.1.1-win32-x64.zip'
$checksum64 = 'fa6d9ef401a79c5ea88f6408d699deb98e9a95b51d514cb071e58f1c5b47c3e2'
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

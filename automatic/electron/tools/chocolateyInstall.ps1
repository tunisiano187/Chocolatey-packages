$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v31.0.2/electron-v31.0.2-win32-ia32.zip'
$checksum = 'db9354bdfe02c183efb26ebf4dabd61be86edb6e002301d1e2a82ea748136fc9'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v31.0.2/electron-v31.0.2-win32-x64.zip'
$checksum64 = '003e03d0dced5bfa242dc8dcdaa52aca8776f57f8ff8cee53e462e22c3a110bd'
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

$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v22.0.0-alpha.4/electron-v22.0.0-alpha.4-win32-ia32.zip'
$checksum = '583b507647259517a8956bed2a2ea351482ec8c037dd9c43307606513b287cc4'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v22.0.0-alpha.4/electron-v22.0.0-alpha.4-win32-x64.zip'
$checksum64 = '3201f5645dbd47cdce472785c8e0e70182e8497d44ee6d0f977cb1e8937e5ba7'
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

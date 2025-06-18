$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v36.5.0/electron-v36.5.0-win32-ia32.zip'
$checksum = 'cb9a263ba2af94d6a909c6144b78e00fe7e087a9ad37f20e6728b1936be12874'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v36.5.0/electron-v36.5.0-win32-x64.zip'
$checksum64 = 'd25ad3cdf24e5f4d9c27f8838a6761166fb4af623aef59dfb372737316162af9'
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

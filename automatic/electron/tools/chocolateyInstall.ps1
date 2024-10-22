$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v33.0.2/electron-v33.0.2-win32-ia32.zip'
$checksum = 'aec325bc05afdab7d463bfd1b0e5d9db67e922f0ee8388b8159093059540fea1'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v33.0.2/electron-v33.0.2-win32-x64.zip'
$checksum64 = 'a14b5bad4b6b04736c0e6bb3d4ad5ad58fd70483f758ca071d0fc162d4178a4c'
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

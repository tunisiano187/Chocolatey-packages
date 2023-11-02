$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v27.0.3/electron-v27.0.3-win32-ia32.zip'
$checksum = '6de967af6a4da56971d9175c2e65009fe13046e78a9f25ba0930f6afec68aff6'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v27.0.3/electron-v27.0.3-win32-x64.zip'
$checksum64 = '8d61deaa158cc2eba43a92e70fcd31a6a519ab740572b0c6feebec99a4c250d1'
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

$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v18.2.1/electron-v18.2.1-win32-ia32.zip'
$checksum = '3ab2ca0aca6746c989f89a240df780fd961e6f82a9be34b4d55871d982409279'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v18.2.1/electron-v18.2.1-win32-x64.zip'
$checksum64 = 'cec9c6b84e4ee6b73df7e20de907128a6cff0ed9e6abb0412987a1d6bdf22158'
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

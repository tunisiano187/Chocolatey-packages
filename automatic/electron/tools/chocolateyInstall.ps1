$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v30.0.3/electron-v30.0.3-win32-ia32.zip'
$checksum = '6b3bc6557d18c3143e4ecf16211c7d9836c2d15a6cd70fc93ab9c835bc5be96e'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v30.0.3/electron-v30.0.3-win32-x64.zip'
$checksum64 = 'd7e8b0aab80f1ce411d3feacc8236379da097610c506719ac848585678344787'
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

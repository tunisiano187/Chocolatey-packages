$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v15.1.1/electron-v15.1.1-win32-ia32.zip'
$checksum = 'c2318f81d01186a927098ff01ced556e8677329ae137d2c3549344823af857d1'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v15.1.1/electron-v15.1.1-win32-x64.zip'
$checksum64 = 'd781380ff7f0d2305587a405b18fb117c3bcfe7fa97942052c4857ed06632fce'
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

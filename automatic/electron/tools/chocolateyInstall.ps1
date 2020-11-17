$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v11.0.0/electron-v11.0.0-win32-ia32.zip'
$checksum = '84f9e7c5c7fe658d6b2eb6212e029c5efd69ab037523f618b88361e818a46902'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v11.0.0/electron-v11.0.0-win32-x64.zip'
$checksum64 = 'c7aaa20f766bb932ae14b453d75ce5b12ea13adbebb4977bc440c8a8cf8b0136'
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

$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v16.0.5/electron-v16.0.5-win32-ia32.zip'
$checksum = 'd4e694d5d1b169024151af54cd75ce5137cb108c9ef1341b619396f285513d97'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v16.0.5/electron-v16.0.5-win32-x64.zip'
$checksum64 = '741fd1cde73efaa6450d4b7f80835bde848e9e3cdb71a86b9e104e0ddf8bdbc6'
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

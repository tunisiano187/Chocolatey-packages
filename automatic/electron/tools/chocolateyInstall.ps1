$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v35.0.1/electron-v35.0.1-win32-ia32.zip'
$checksum = 'e803bca355eb73dbda99db4e1806024e37ca62a80e37f945e1babf09a2430d58'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v35.0.1/electron-v35.0.1-win32-x64.zip'
$checksum64 = '4d1e6183a07c43aa4b773df77534125681e269b7b2df2223525edd034ff32dbe'
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

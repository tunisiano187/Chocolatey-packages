$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v26.0.0/electron-v26.0.0-win32-ia32.zip'
$checksum = '97ef1dbd716e31d7d90c9e7602030644ac51ee7617dd9fac72b017b8fe92e990'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v26.0.0/electron-v26.0.0-win32-x64.zip'
$checksum64 = 'be53b2c624f2f0f438678a276044c632becf4df1ad9a26edfc590e1259e93ac1'
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

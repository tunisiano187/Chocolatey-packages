$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v19.0.9/electron-v19.0.9-win32-ia32.zip'
$checksum = 'b8f00e0ea4b72aafacf9e855e11c1638f174b32ca007053a153c1ae84aa9a12c'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v19.0.9/electron-v19.0.9-win32-x64.zip'
$checksum64 = '4f1bc8a64897b50c68fbb2159cb40e1701a7a2e64110342dd9fc0e6a8e16f441'
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

$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v32.0.1/electron-v32.0.1-win32-ia32.zip'
$checksum = 'bb204179ed41c2f39fd0fe4accd6350e53c810c11e82c360813ce5260d7fac8c'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v32.0.1/electron-v32.0.1-win32-x64.zip'
$checksum64 = '9153c1d72658472db6b34f094c190178099ebdfb02d6c82caf42010820580a52'
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

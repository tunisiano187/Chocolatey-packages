$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v13.1.0/electron-v13.1.0-win32-ia32.zip'
$checksum = '6d5f27c483874fd2f399e1cd66fbdd1764df71181fdf40fbf7541c6ce5fec0ee'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v13.1.0/electron-v13.1.0-win32-x64.zip'
$checksum64 = 'dea5e784471828dedb294801f0d35a11459b2a940b6b60ed80c2c19eccd4d8f2'
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

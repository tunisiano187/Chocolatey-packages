$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v42.5.0/electron-v42.5.0-win32-ia32.zip'
$checksum = 'aa040c36074046a723fca9173aac1c8bf70c19d8a156215e8dbeb17ea37f588b'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v42.5.0/electron-v42.5.0-win32-x64.zip'
$checksum64 = '127bbf7a755b438612c076b22baee258a87cd3d07168cc82ea46ffc015936114'
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

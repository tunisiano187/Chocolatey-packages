$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v17.1.0/electron-v17.1.0-win32-ia32.zip'
$checksum = 'c44d543e3a7a6b00cd07b29972b076523755d9be12e324ff53c2f7c993e4d314'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v17.1.0/electron-v17.1.0-win32-x64.zip'
$checksum64 = '9984afeb9def65f615358b4bd7c5b6371b1bc11c44d4a7aff25d5129443cd815'
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

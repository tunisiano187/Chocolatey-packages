$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v35.1.3/electron-v35.1.3-win32-ia32.zip'
$checksum = 'b0b2fd098abd78bdd9376e547df8f0eea263888231015f7b64f6550d82d50ea9'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v35.1.3/electron-v35.1.3-win32-x64.zip'
$checksum64 = 'db1fdd9063b0205bb18c3f7c5686cb203dd11867dcbf76f2cd0f5532da196be1'
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

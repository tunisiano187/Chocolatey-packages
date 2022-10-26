$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v22.0.0-beta.1/electron-v22.0.0-beta.1-win32-ia32.zip'
$checksum = 'c1f45aac04c9d9572355c9f3b7b908ebb5395ec2154c8cb9787e15388d2498ea'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v22.0.0-beta.1/electron-v22.0.0-beta.1-win32-x64.zip'
$checksum64 = 'd0a08f147dc547232dcb6757f7bd4562f72fe54af243cc433c792d3bd321761b'
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

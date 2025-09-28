$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v38.2.0/electron-v38.2.0-win32-ia32.zip'
$checksum = 'b3bd0de05613ab5312013133de1587c35fdfa22e11e1f76fcaf6ea0248128f0c'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v38.2.0/electron-v38.2.0-win32-x64.zip'
$checksum64 = '4382b317dbbbc0bbf8a301304749324b88207218aac240b670f1c1247c2a02b0'
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

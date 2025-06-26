$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v37.1.0/electron-v37.1.0-win32-ia32.zip'
$checksum = '105aa2805ea59fa2f1b75a51d9937d180b0ff41e7dffc5887b14fcd3169ce3a3'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v37.1.0/electron-v37.1.0-win32-x64.zip'
$checksum64 = '761319fc6a32fb384a061d65fd60144dadbd62f68ac44acdd644ebd022cb5d05'
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

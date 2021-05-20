$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v12.0.9/electron-v12.0.9-win32-ia32.zip'
$checksum = '79511fd649071b81d678ce2651c8103bb31c422b965f8a26af2694e243c6396d'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v12.0.9/electron-v12.0.9-win32-x64.zip'
$checksum64 = '3ae9f8f94002d91b57dbd531460e6ded3ac67415c391fe8568e20cd6149ac274'
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

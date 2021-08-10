$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v13.1.9/electron-v13.1.9-win32-ia32.zip'
$checksum = 'd077991c094f1b79e77df81ecf3366fef7940b87c6caf9032343fcf7786be1cd'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v13.1.9/electron-v13.1.9-win32-x64.zip'
$checksum64 = '681cd637b2eaaf3fe35684c0d030349356d4ff0cf29e27697ac8574d38d0ad61'
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

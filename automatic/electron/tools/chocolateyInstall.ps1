$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v22.0.0-beta.2/electron-v22.0.0-beta.2-win32-ia32.zip'
$checksum = '213418a65a3d89b84caf82fbed375f0e086c8cb325da5c66d18a7f23f7122396'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v22.0.0-beta.2/electron-v22.0.0-beta.2-win32-x64.zip'
$checksum64 = '1468283df08e14dd7a2c1d4b2cb0fd311384a3b6666bcc8eccb85087101fee17'
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

$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v31.2.1/electron-v31.2.1-win32-ia32.zip'
$checksum = '1c5c7f160350fee961f5f19ad5e7e40f0ce9a5df415cc395e1820d043751d1f8'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v31.2.1/electron-v31.2.1-win32-x64.zip'
$checksum64 = 'cdbb839305dade6e9c5b82df9868c620b6975ccae2a50a360f5358b6bbfca13b'
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

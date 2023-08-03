$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v25.4.0/electron-v25.4.0-win32-ia32.zip'
$checksum = '14320e1f7db40e885ee101acd39698be58745cdfe6a519e0a5316269837f5bf7'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v25.4.0/electron-v25.4.0-win32-x64.zip'
$checksum64 = '6f0c6da70a4daa50ec46c389896d08009ce14cdac5896c608e5af8956fd359de'
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

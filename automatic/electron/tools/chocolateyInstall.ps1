$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v11.2.2/electron-v11.2.2-win32-ia32.zip'
$checksum = 'f8353ce157b2faeb89e9ca59a19814a0d9e7183c42d165ecf0616aac96b4d841'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v11.2.2/electron-v11.2.2-win32-x64.zip'
$checksum64 = 'd1d866c81c283a38387138ae71a95e5fb2f40e0cf1a2750c69894e5311f54bc3'
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

$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v25.0.1/electron-v25.0.1-win32-ia32.zip'
$checksum = 'bc9a5df94b33ce7c7d21dc7dfe34db4dbecc31c315076e7a611661b236a181fa'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v25.0.1/electron-v25.0.1-win32-x64.zip'
$checksum64 = '63cc9219f432ed02defa5b1f5b1fb71bd04eee0276636866c3613d43631a12c8'
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

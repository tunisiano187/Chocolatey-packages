$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
# Electron stopped publishing a win32-ia32 (32-bit Windows) build as of v44 -- 64-bit only now.
$url = 'https://github.com/electron/electron/releases/download/v43.4.1/electron-v43.4.1-win32-x64.zip'
$checksum = 'c2ef9a5f65472c34d14bd3e67b7d14e66b0c01f124aba45263d6a4232160e13a'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"

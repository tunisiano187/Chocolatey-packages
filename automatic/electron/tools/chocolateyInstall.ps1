$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v31.4.0/electron-v31.4.0-win32-ia32.zip'
$checksum = 'a523351119680f38d27bc0abcb9051c8c55a38c494cd982af0377a65e28f7c11'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v31.4.0/electron-v31.4.0-win32-x64.zip'
$checksum64 = 'ec065fc23dac9c84685c8b67fa2bc738a809ef4428f6b7fe106a690f8c87db6b'
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

$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v22.0.0-alpha.5/electron-v22.0.0-alpha.5-win32-ia32.zip'
$checksum = '807c13918639a608e11d49df889280fadaced86041710a83b05418e80f336819'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v22.0.0-alpha.5/electron-v22.0.0-alpha.5-win32-x64.zip'
$checksum64 = '01a51dc3e16a0f8475a8c174f50883ce05196e00f84458ef78b68bbe44b5bcb8'
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

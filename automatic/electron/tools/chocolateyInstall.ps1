$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v43.1.1/electron-v43.1.1-win32-ia32.zip'
$checksum = '837a90b3a5e6ca9144df945b68179e69c30a7e2498cfc2a76af142f852ef8f08'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v43.1.1/electron-v43.1.1-win32-x64.zip'
$checksum64 = 'b4e9995cd3f65785eb8818276aa9020f3165ab11da41b3c762616d4a0ad8c7ad'
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

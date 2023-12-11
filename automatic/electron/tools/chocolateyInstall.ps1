$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v28.0.0/electron-v28.0.0-win32-ia32.zip'
$checksum = '56acba78e9239896546c39bde450fa64dd4be649e4540a990632950464ba57ab'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v28.0.0/electron-v28.0.0-win32-x64.zip'
$checksum64 = '057f803336ea7023e6593aa5a809962a6956adfac43c34223e7c9b70b2836e87'
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

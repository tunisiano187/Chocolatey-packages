$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v29.3.0/electron-v29.3.0-win32-ia32.zip'
$checksum = '02e449a761f08ff710c3ed04a64940efbf6358071362b964c0f8e2f88f132a5d'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v29.3.0/electron-v29.3.0-win32-x64.zip'
$checksum64 = '4c7adf366cd0747d072aec23ff22837c9b016336a0bc26d64bffdd7869ad4bd2'
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

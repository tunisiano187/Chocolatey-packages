$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v43.3.0/electron-v43.3.0-win32-ia32.zip'
$checksum = '2ffc4e320dc8fa25a0ab872723cd19012d8eb3479768ce424f284d1409a5a76d'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v43.3.0/electron-v43.3.0-win32-x64.zip'
$checksum64 = '18528bedc6a9b04bdc5efb7b803cbc3cb0e5ea6415d54046e23d464d89a00da9'
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

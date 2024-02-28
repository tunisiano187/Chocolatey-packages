$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v29.1.0/electron-v29.1.0-win32-ia32.zip'
$checksum = '7eb5a875599c4e6979b7049f411c72780220870565895c67bbcd541f8525296d'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v29.1.0/electron-v29.1.0-win32-x64.zip'
$checksum64 = '2785358d5940142f00351425122bcaceebaf1d47ba5dac982c2a093a673d3908'
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

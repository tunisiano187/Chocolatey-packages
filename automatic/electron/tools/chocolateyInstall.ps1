$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v29.0.0/electron-v29.0.0-win32-ia32.zip'
$checksum = '6352881301983524721c92875d3f8ac36d291f9fc92e29ec546bedc38ccdf7aa'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v29.0.0/electron-v29.0.0-win32-x64.zip'
$checksum64 = '2639165790888edb61ef42de397766aaacc4e455feb8827fe0da8e66b360c2b2'
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

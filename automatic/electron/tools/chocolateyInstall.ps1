$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v40.2.1/electron-v40.2.1-win32-ia32.zip'
$checksum = '39dc33bf502a0272568809c43f354133057cdb9080ab1109102c4e0142762b02'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v40.2.1/electron-v40.2.1-win32-x64.zip'
$checksum64 = 'd0f9ad5f01f45b03bca4a7b0c3f6bd80a3b00bc371a9829562a997713dbd84e4'
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

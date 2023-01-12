$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v22.0.1/electron-v22.0.1-win32-ia32.zip'
$checksum = '6c84ecce9ddf8e08696109214edfa99edcbc4607594234554eb34791ceeb1c86'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v22.0.1/electron-v22.0.1-win32-x64.zip'
$checksum64 = 'c364e43c1a4215e5737bf56c13a5a1aed0b667c8dac4e498f4eb95ce9cb019a0'
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

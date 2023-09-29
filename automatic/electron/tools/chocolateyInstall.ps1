$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v26.2.4/electron-v26.2.4-win32-ia32.zip'
$checksum = '4253cb7ff9bf1279f0c59abf22691678c46e88a47d267dc3923deaf16445baae'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v26.2.4/electron-v26.2.4-win32-x64.zip'
$checksum64 = '840b8aa8580b73ef7e90b7c5b449a3e4132fe7ccef4402bdc36db8369e9b8f14'
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

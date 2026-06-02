$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v42.3.1/electron-v42.3.1-win32-ia32.zip'
$checksum = 'c46b1a0dfc42b5d6d85bbecaf6870c2f780275da327cca4932876fd045eae735'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v42.3.1/electron-v42.3.1-win32-x64.zip'
$checksum64 = 'dd36bb3eb443fc5fdad5bc48e0195be3b91a2bf5f5de3d283c039eb06784c04b'
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

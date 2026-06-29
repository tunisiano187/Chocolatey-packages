$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v42.5.1/electron-v42.5.1-win32-ia32.zip'
$checksum = '9fae3ad1c62415b0a5dee3ae4dfdb04929f31b65add6e470a8a355c6a8596b46'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v42.5.1/electron-v42.5.1-win32-x64.zip'
$checksum64 = '2fb8b988777e00c1e349568d0f796894404d6253900600aea5d19315b977fbca'
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

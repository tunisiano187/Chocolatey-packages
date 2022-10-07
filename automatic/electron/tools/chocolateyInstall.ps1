$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v22.0.0-alpha.3/electron-v22.0.0-alpha.3-win32-ia32.zip'
$checksum = 'b6e42d962c952f98f75e536ff7414ca175b123b43c9d6bc77a2bc7b03504a379'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v22.0.0-alpha.3/electron-v22.0.0-alpha.3-win32-x64.zip'
$checksum64 = '0d9489f7b5a17bd5cdba183ab4aeeeb1ede8cb22ea1ae48c668e83cc369cc31e'
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

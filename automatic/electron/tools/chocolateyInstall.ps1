$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v26.2.3/electron-v26.2.3-win32-ia32.zip'
$checksum = 'd535a27d1824facb5b683ba64eb2fe89b39b1c1aca5b256d61e76d56c17df38a'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v26.2.3/electron-v26.2.3-win32-x64.zip'
$checksum64 = '8438aa60732b329bb7f91ed680b8aa19875a6b1fd7c10b9aa795339700df4c51'
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

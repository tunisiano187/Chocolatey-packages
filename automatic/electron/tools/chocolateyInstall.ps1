$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v17.1.2/electron-v17.1.2-win32-ia32.zip'
$checksum = '5fc04e1ffa176f30c5ecf3c4451b3e5866b44fd2b64ec008d462f15d01aefbed'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v17.1.2/electron-v17.1.2-win32-x64.zip'
$checksum64 = 'feff785841aea32a59abe4b57a78e49f6e35821619654fe2599a0ff1bc5e5e81'
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

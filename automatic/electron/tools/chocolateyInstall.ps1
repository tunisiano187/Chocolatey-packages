$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v40.4.0/electron-v40.4.0-win32-ia32.zip'
$checksum = '51e31ea43289065f81d29e213c919e46332d4aa77510b24f8df18d387a5ee248'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v40.4.0/electron-v40.4.0-win32-x64.zip'
$checksum64 = 'd3f15c97ba68dad570d10b139f4bf11b5b58efbc8409f2ffda310990a5a329a6'
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

$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v42.3.0/electron-v42.3.0-win32-ia32.zip'
$checksum = '6f3d09af41871b22a05c1d78ba85e2dc6c1f5657239b0a1ff7bb2ef1b844b823'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v42.3.0/electron-v42.3.0-win32-x64.zip'
$checksum64 = '01889ff05a2852b86f34e274f0fd7dc41f31ccc500a8d4e07d43f4984b8cec9a'
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

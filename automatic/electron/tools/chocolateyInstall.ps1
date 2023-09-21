$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v26.2.2/electron-v26.2.2-win32-ia32.zip'
$checksum = '185a6141e4c67cb19987499432195b654639359816cc16e79c0117bc1a15015f'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v26.2.2/electron-v26.2.2-win32-x64.zip'
$checksum64 = '26e7ead7db6b9acb2e904499321c0283d497add115a528157b8c3853e44fcefd'
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

$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v33.0.1/electron-v33.0.1-win32-ia32.zip'
$checksum = 'e39abc9930cfdb6083ebb03da61d5e586132f789bd24f86a02980f2eb29f3df6'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v33.0.1/electron-v33.0.1-win32-x64.zip'
$checksum64 = 'cf42128a239924fb37b8dce1de508b636155baeba50232f04d7b087ed700ac82'
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

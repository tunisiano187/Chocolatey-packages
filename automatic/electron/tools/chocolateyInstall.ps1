$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v36.3.2/electron-v36.3.2-win32-ia32.zip'
$checksum = '27fcd4f8bb56ffaaea6ce455397c48098a0eec161f7f86b0f5fd503f4b0bcf07'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v36.3.2/electron-v36.3.2-win32-x64.zip'
$checksum64 = '5475dc725d50c9cee12c0d56e1fd093c3bad75e9dfafd9753fddc3a085532a37'
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

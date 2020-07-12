$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v8.4.0/electron-v8.4.0-win32-ia32.zip'
$checksum = '7b138832541fda690228c116120aa8859730aa009fc2fd2c2851212b5cad4181'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v8.4.0/electron-v8.4.0-win32-x64.zip'
$checksum64 = 'bb208f693fc9cf20ff4616dc86607effc20eb5c069aef50e8e6a4bd9716c1ed2'
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

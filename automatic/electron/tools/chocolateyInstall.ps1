$packageName = 'electron'
$url = 'https://github.com/electron/electron/releases/download/v8.3.3/electron-v8.3.3-win32-ia32.zip'
$checksum = 'b0d7edc16599bb7b343be8f7bc6eee79d82e0ed798b556b3fa52785a9bf1ad04'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v8.3.3/electron-v8.3.3-win32-ia32.zip'
$checksum64 = 'b0d7edc16599bb7b343be8f7bc6eee79d82e0ed798b556b3fa52785a9bf1ad04'
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

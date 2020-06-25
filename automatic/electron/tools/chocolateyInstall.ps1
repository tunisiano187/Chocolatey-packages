$packageName = 'electron'
$url = 'https://github.com/electron/electron/releases/download/v8.3.4/electron-v8.3.4-win32-ia32.zip'
$checksum = 'e0b22a15c69da52016cabfbe548e54197a94e09365c8d4cd9a31564827fe606b'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v8.3.4/electron-v8.3.4-win32-ia32.zip'
$checksum64 = 'e0b22a15c69da52016cabfbe548e54197a94e09365c8d4cd9a31564827fe606b'
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

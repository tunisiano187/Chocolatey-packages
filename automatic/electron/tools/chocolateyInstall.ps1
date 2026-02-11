$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v40.3.0/electron-v40.3.0-win32-ia32.zip'
$checksum = '672b61dcccd4d35cbef18dc0c9a30ef064c0881c9d63ce5e0d79516e861f52d7'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v40.3.0/electron-v40.3.0-win32-x64.zip'
$checksum64 = '2b9922e6c11cda3b70b3009e831ef7cfbc65181ffbd4927e4f3961ff00cd0247'
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

$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v40.1.0/electron-v40.1.0-win32-ia32.zip'
$checksum = '4e8c8ade8cf2cb7b12d00132aee3539236dcc9e22db4a62b2baac192c4c824c9'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v40.1.0/electron-v40.1.0-win32-x64.zip'
$checksum64 = '1a7acfd64ac2d4240ba7f71475625e2c9b8b04fdfa647bb91d48b7b1a02b9266'
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

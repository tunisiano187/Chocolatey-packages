$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v17.3.0/electron-v17.3.0-win32-ia32.zip'
$checksum = '918d7fff0919946dc550678c830ebfd473584dfd5fbf515f97ca72a5183c3ae7'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v17.3.0/electron-v17.3.0-win32-x64.zip'
$checksum64 = 'd7c85f359fb254c0b80af3605e60db2230a1148c12b19c0611d63351a93a340f'
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

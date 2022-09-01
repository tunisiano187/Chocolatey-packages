$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v20.1.1/electron-v20.1.1-win32-ia32.zip'
$checksum = 'a4261d814eeb5dbc09f5447368b12964498372139400bff8f7e375d011353806'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v20.1.1/electron-v20.1.1-win32-x64.zip'
$checksum64 = 'a933bbb9e416cdd814b489327d88543b553fe4944667861b0feac50ba4498923'
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

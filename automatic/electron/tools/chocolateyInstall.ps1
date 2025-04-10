$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v35.1.5/electron-v35.1.5-win32-ia32.zip'
$checksum = '267e1ef8a806db811e3f89ac483be847757b53d2ea9ce57ca0aa1dd3cf781d4f'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v35.1.5/electron-v35.1.5-win32-x64.zip'
$checksum64 = 'd96947bb5111db344d5acedd9ce7bc2eb0c7d28992bf6307d0efeee2589c4ba2'
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

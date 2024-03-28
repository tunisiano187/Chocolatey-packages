$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v29.1.6/electron-v29.1.6-win32-ia32.zip'
$checksum = 'e8b4de579475409a1ece28d637d03b23116ddbbdb83e164c62312d75a743be9d'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v29.1.6/electron-v29.1.6-win32-x64.zip'
$checksum64 = '668d6fda36abd1ab51c366afd787bb941818a35412c2ec4945eb523600eef0f2'
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

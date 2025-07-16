$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v37.2.2/electron-v37.2.2-win32-ia32.zip'
$checksum = 'd4ebc510809eb85cc3c2b1c1803b1a1b7ef65e0bfc1ad2c30244a54bc783810e'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v37.2.2/electron-v37.2.2-win32-x64.zip'
$checksum64 = '544c630d019412550a09d2e31178495006761d457e50f96b55a53a3ae29b760f'
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

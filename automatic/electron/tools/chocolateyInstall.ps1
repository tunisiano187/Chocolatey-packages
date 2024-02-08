$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v28.2.2/electron-v28.2.2-win32-ia32.zip'
$checksum = 'c57691b73592632829cef136be6dd356a82331450920fd024ac3589654d23550'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v28.2.2/electron-v28.2.2-win32-x64.zip'
$checksum64 = '5fbc76585891b0d7b09c938f7be25b7ab36b3768491021b053dc99bc70a8aa29'
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

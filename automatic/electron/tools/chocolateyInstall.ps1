$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v38.3.0/electron-v38.3.0-win32-ia32.zip'
$checksum = '3da543631058289d208273c8d10fbce536e38524a58d6a4392a2afa1acfd21d2'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v38.3.0/electron-v38.3.0-win32-x64.zip'
$checksum64 = 'fa9839945f9ab3a96863bf8c4bea495a950d074d637725a2f98e2dd37c786a5a'
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

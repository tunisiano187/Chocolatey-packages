$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v24.4.0/electron-v24.4.0-win32-ia32.zip'
$checksum = '1e34478a337cad720f1429fae8865a7853de56e0d4936519bc2a1cdeca0a7295'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v24.4.0/electron-v24.4.0-win32-x64.zip'
$checksum64 = '96a1c0432f409b8052e92fba94692243fa489891926946f836d3e28e78bd34b7'
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

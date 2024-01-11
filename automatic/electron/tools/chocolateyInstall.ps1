$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v28.1.3/electron-v28.1.3-win32-ia32.zip'
$checksum = '5912d72741a634af082a0cb5a9970bf63c4a1a520490c5bb9f47bf401249d75c'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v28.1.3/electron-v28.1.3-win32-x64.zip'
$checksum64 = '443f6338153d5f39e10e73427a147e43f60ef9ba8ba10a3d65efc9d38bb035e4'
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

$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v41.0.2/electron-v41.0.2-win32-ia32.zip'
$checksum = 'aeb2d2358e1bf173a59e707a24d25093864807bd1dbad1a585ede6c5e6392472'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v41.0.2/electron-v41.0.2-win32-x64.zip'
$checksum64 = 'dcd36396a606a5ae2f5651b4ee6bb463a624dbf15f786eda57cee2cc361c138c'
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

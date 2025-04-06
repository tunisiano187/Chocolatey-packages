$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v35.1.4/electron-v35.1.4-win32-ia32.zip'
$checksum = '06cfe544591e49831ceab93be5dcb61c2b78e9e2e8afc4599ce8a3bac118d469'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v35.1.4/electron-v35.1.4-win32-x64.zip'
$checksum64 = 'b7f2fd102b7fd5e5b2c226e83253ad0cb34d50d858d6a471baa69e24f817b03f'
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

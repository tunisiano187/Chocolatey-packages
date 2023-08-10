$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v25.5.0/electron-v25.5.0-win32-ia32.zip'
$checksum = '7e6e68aa33a89c0d647575b06daf415a2401feb170ebb9cd795e221af321f751'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v25.5.0/electron-v25.5.0-win32-x64.zip'
$checksum64 = '9bf7980fbc024ba77ea8ab3e2d32088a5f69bf32506a7d2db72ede17028abdf4'
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

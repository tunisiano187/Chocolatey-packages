$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v30.1.0/electron-v30.1.0-win32-ia32.zip'
$checksum = '59633d4af2bf1226c6dc0b0609ff93091ce55a799686a8a8f27dd94301382273'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v30.1.0/electron-v30.1.0-win32-x64.zip'
$checksum64 = '82fb4cff5b2d68ffba933e8ad28b8b48a9aa807bf77048c52adda34c10acedf2'
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

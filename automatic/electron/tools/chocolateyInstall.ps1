$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v13.1.8/electron-v13.1.8-win32-ia32.zip'
$checksum = 'a5dedae93fcf4ca6df4ec8843c5b39051b773ef7493d4c1c20df4e7dfbcfc44a'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v13.1.8/electron-v13.1.8-win32-x64.zip'
$checksum64 = '51e547bf872cd985bbca4ef9c0910cf2eedb9f190f471a7e98665713643a063d'
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

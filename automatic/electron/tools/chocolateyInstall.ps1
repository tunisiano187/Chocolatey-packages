$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v19.0.4/electron-v19.0.4-win32-ia32.zip'
$checksum = 'e390f7841bd7247786c817fe5c4fef6a547fc00f66dad3277cd233d115ef2162'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v19.0.4/electron-v19.0.4-win32-x64.zip'
$checksum64 = 'dea9a901efdacd0c7c5bea427f587a996748f85bf724045808da6d84157aab3f'
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

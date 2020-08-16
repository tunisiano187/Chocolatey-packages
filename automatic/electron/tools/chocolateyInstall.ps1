$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v9.2.0/electron-v9.2.0-win32-ia32.zip'
$checksum = '71f4de93dd0919fdf24a8dba786647c056a9e986c77847c864b6046a3a4fc755'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v9.2.0/electron-v9.2.0-win32-x64.zip'
$checksum64 = 'b2c0a62e51906d6e4beab2328942a54f0f4aa1c7e31cae6985a821000b7d9c79'
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

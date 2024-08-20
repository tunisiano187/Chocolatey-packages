$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v32.0.0/electron-v32.0.0-win32-ia32.zip'
$checksum = 'afa953a5a6ff6c7bce8313a2bb8fd1b6a75fc0f37f0229457205dc10f91232d1'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v32.0.0/electron-v32.0.0-win32-x64.zip'
$checksum64 = 'e562b6d536191d11f1af210bf612ad980ca083817022eaa3616df316ce03ec72'
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

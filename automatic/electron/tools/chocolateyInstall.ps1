$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v27.0.2/electron-v27.0.2-win32-ia32.zip'
$checksum = '1884eacb4ee6b54e46c391b7c2e57b73f210ff855c1db0c890014649ddd3ffc7'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v27.0.2/electron-v27.0.2-win32-x64.zip'
$checksum64 = '1545d204937079a1c8fe675062c04351ad45dec37336eec8cbee44acd74d29dc'
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

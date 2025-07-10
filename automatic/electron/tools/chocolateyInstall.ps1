$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v37.2.1/electron-v37.2.1-win32-ia32.zip'
$checksum = '746d8a6b2a46bd60c4b4086647537a6360542488f582e75a080438586c13ad04'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v37.2.1/electron-v37.2.1-win32-x64.zip'
$checksum64 = '0c94911d177012468301568d8b4dc380b6f538c0ac185a354b6e48c669675562'
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

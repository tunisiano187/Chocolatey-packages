$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v11.1.1/electron-v11.1.1-win32-ia32.zip'
$checksum = 'b8d959b0182fa4b4fea7f690829d1f2de9c9bb84eb84712242d51587bb6dcaac'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v11.1.1/electron-v11.1.1-win32-x64.zip'
$checksum64 = 'f9b4e8ce30b3deaa1e5e431c4d6287b207409eac959aee19c01a6b320ce1af20'
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

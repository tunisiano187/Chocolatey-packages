$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v25.3.2/electron-v25.3.2-win32-ia32.zip'
$checksum = 'b58103f55d7d4fa2bb72c807d353556bfb077b405bcba0526b34882f559f7325'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v25.3.2/electron-v25.3.2-win32-x64.zip'
$checksum64 = '152df697cc396c8dce2c405d25ceeb2499f335dd99a66b32fd8749f6042f27d7'
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

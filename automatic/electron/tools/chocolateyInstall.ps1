$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v9.1.2/electron-v9.1.2-win32-ia32.zip'
$checksum = '78400cbf365b5e6b3c323bd5c877aa53f1e2454a32818967aac688edd9a9d617'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v9.1.2/electron-v9.1.2-win32-x64.zip'
$checksum64 = '5d004e34bd1d16967cedbe98d1a00ed6bfe3b2bb9f066cc2d6dac44deb8ab938'
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

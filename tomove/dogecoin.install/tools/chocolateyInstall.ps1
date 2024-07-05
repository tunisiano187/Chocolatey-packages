$ErrorActionPreference = 'Stop'
$packageName = '$env:ChocolateyPackageName'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.7/dogecoin-1.14.7-win32-setup-unsigned.exe'
$checksum = '738e70d06263e20f06304fbbd1b0e1481a7d0da3434b675e4b1e680644c09b8a'
$checksumType = 'sha256'
$url64 = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.7/dogecoin-1.14.7-win64-setup-unsigned.exe'
$checksum64 = 'e1bc8be88d22af22bb26c2d87cfe497a808fc54817921ced416392a1ed78c0a2'
$checksumType64 = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -Url64bit "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"

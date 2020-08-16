$ErrorActionPreference = 'Stop'
$packageName = '{{PackageName}}'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.2/dogecoin-1.14.2-win32-setup-unsigned.exe'
$checksum = '1650ed3ee65fdb74237f4af97a396377db2f359f08158d1a2fe9e22a975b8e3e'
$checksumType = 'sha256'
$url64 = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.2/dogecoin-1.14.2-win64-setup-unsigned.exe'
$checksum64 = 'dc8cd7efd1318b293c473fbe4ab5aac994e78b9e379aa03fb166cee352f06e28'
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

$ErrorActionPreference = 'Stop'
$packageName = '$env:ChocolateyPackageName'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.6/dogecoin-1.14.6-win32-setup-unsigned.exe'
$checksum = 'c3dd01612f70afaf7b293199e016feeb8c5071fbb673a02a3baf24d04014cc02'
$checksumType = 'sha256'
$url64 = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.6/dogecoin-1.14.6-win64-setup-unsigned.exe'
$checksum64 = '888429200b5cd1a414e33215e8e8aea0957fa7a615c407b19b8a9ab2fa9e180a'
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

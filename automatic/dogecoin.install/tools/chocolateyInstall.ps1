$ErrorActionPreference = 'Stop'
$packageName = '$env:ChocolateyPackageName'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.4/dogecoin-1.14.4-win32-setup-unsigned.exe'
$checksum = 'c1bee4eeb90a1d3b2f058a3cf725b618d16b21d9c84b5bdcbd989c8ceb7e9de3'
$checksumType = 'sha256'
$url64 = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.4/dogecoin-1.14.4-win64-setup-unsigned.exe'
$checksum64 = 'c683e321e71000730ee6f742b49ce1a14e9471a32e29cd54d56fe417d9d690aa'
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

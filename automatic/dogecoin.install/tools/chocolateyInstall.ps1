$ErrorActionPreference = 'Stop'
$packageName = '$env:ChocolateyPackageName'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.3/dogecoin-1.14.3-win32-setup-unsigned.exe'
$checksum = '74190511fd882631ca4b467715ec26771eb4ba3cb0e8896f50d6dc840ee0cfd7'
$checksumType = 'sha256'
$url64 = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.3/dogecoin-1.14.3-win64-setup-unsigned.exe'
$checksum64 = '37aafa689c193feb6d66e4ed30f9aaf899f4065a5b002f6962ce02a200d9116b'
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

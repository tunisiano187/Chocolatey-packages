$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/S'
$url64          = 'https://bitcoincore.org/bin/bitcoin-core-23.0/bitcoin-23.0-win64-setup.exe'
$checksum64     = '4198eba8ac326d8746ab43364a44a5f20c157b6701f8c35b80d639a676df9011'
$checksumType64 = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url64bit "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"

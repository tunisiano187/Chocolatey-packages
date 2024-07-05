$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/S'
$url64          = 'https://bitcoincore.org/bin/bitcoin-core-27.1/bitcoin-27.1-win64-setup.exe'
$checksum64     = 'e8ab7a8161c5a0846c81275809c9f90302874cc71b4378dee540f0b380a6d049'
$checksumType64 = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url64bit "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"

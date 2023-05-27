$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/S'
$url64          = 'https://bitcoincore.org/bin/bitcoin-core-25.0/bitcoin-25.0-win64-setup.exe'
$checksum64     = '69fa4b86e335238e7631bcb062dd17eb100708cc5a7388edce921a0ec6737bca'
$checksumType64 = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url64bit "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"

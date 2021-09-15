$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/S'
$url64          = 'https://bitcoincore.org/bin/bitcoin-core-22.0/bitcoin-22.0-win64-setup.exe'
$checksum64     = '9169989d649937c0f9ebccd3ab088501328aa319fe9e91fc7ea8e8cf0fcccede'
$checksumType64 = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url64bit "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"

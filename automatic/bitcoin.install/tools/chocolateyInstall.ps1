$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/S'
$url64          = 'https://bitcoincore.org/bin/bitcoin-core-31.1/bitcoin-31.1-win64-setup.exe'
$checksum64     = 'd0c6d0f3cd08689472a6f53c4ce33a5f059c092758c32c42541b47db4e193458'
$checksumType64 = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url64bit "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"

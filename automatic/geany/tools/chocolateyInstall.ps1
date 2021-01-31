$packageName = 'geany'
$installerType = 'exe'
$silentArgs = '/S'
$url32 = 'https://github.com/geany/geany/releases/download/1.37.1/geany-1.37.1_setup.exe'
$checksum32 = '7ad1d76ab4ab5f56e94df8859007658b2cc8870d9a6b32e8b7487b29d21ecc0d'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType"

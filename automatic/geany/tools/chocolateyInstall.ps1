$packageName = 'geany'
$installerType = 'exe'
$silentArgs = '/S'
$url32 = 'https://github.com/geany/geany/releases/download/2.0.0/geany-2.0_setup.exe'
$checksum32 = 'c23139d7b15f9716a09b46efaceb60532458fbc08f78374987ab8602875d5a40'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType"

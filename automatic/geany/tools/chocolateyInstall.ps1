$packageName = 'geany'
$installerType = 'exe'
$silentArgs = '/S'
$url32 = 'http://download.geany.org/geany-1.36_setup.exe'
$checksum32 = '1549b62f9e9fdde825ae45245bafc3a47ce85f4555f28b06e3a9c600340751df'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType"
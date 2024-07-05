$packageName = 'geany'
$installerType = 'exe'
$silentArgs = '/S'
$url32 = 'https://github.com/geany/geany/releases/download/2.0.0/geany-2.0_setup.exe'
$checksum32 = 'fdc3e8d183533ae0c87ff3c2b035166e6a4d31379a2014320abd552d5558d8e9'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType"

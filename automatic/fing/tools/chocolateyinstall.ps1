$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S'
$url32 = 'https://get.fing.com/fing-desktop-releases/win/Fing.exe'
$checksum32 = 'e5376ad07ae04ed75add57c809436bde9e691c7d46ac40eed7efeda1a63018e3'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType"

$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S'
$url32 = 'https://get.fing.com/fing-desktop-releases/windows/Fing.exe'
$checksum32 = '6742c8a52bdc7431b9031b67ce7ed22be0d01f39f38e6c75c8c8c2cea2b2f0a7'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType"

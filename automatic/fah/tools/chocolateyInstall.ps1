$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S'
$url32       = 'https://download.foldingathome.org/releases/public/fah-client/windows-10-64bit/release/fah-client_8.4.9_AMD64.exe'
$checksum32 = '9664979343247bddf709538e0af5dea7363d835474ff202aa96c5a40b9718a99'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType" `


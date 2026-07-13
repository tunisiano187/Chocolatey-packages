$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S'
$url32       = 'https://download.foldingathome.org/releases/public/fah-client/windows-10-64bit/debug/fah-client_8.5.6_AMD64.exe'
$checksum32 = '8342f64f6f3280dbec18cde724db755d915c003cffd393d09f0877ac96c8c3ed'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType" `


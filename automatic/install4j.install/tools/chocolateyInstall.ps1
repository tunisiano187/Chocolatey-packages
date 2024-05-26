$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '-q'
$url            = 'https://download.ej-technologies.com/install4j/install4j_windows-x64_10_0_8.exe'
$checksum       = '934a636a9c238697ed0f02b0a74d8455b802574cdf8a2b954e62610747e0cb1d'
$checksumType   = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"

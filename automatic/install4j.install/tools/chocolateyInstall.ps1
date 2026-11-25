$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '-q'
$url            = 'https://download.ej-technologies.com/install4j/install4j_windows-x64_13_2.exe'
$checksum       = '471bbe314a9ff36d8f6769093c199a358a09030b1810cfc59a02f66d73923e36'
$checksumType   = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"

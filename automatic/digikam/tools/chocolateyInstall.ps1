$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/S'
$url64          = 'https://download.kde.org/stable/digikam/7.9.0/digiKam-7.9.0-Win64.exe'
$checksum64     = 'b67d1ec75a3a28fe24acc936927b02b03ac59bac257cea8bc4fa0644107020b4'
$checksumType64 = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -url64bit "$url64" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64" `
                          -ValidExitCodes $validExitCodes

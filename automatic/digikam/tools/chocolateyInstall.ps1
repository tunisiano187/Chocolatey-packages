$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/S'
$url64          = 'https://download.kde.org/stable/digikam/9.1.0/digiKam-9.1.0-Qt6-Win64.exe'
$checksum64     = '28ef373ab45ecc7eb1fd105b57828a29588504eb5a286c9e89c987c056bce8be'
$checksumType64 = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -url64bit "$url64" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64" `
                          -ValidExitCodes $validExitCodes

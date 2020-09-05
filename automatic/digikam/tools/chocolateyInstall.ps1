$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/S'
$url32          = 'https://download.kde.org/stable/digikam/7.1.0/digiKam-7.1.0-Win32.exe'
$checksum32     = 'b413c1e37ed64fad48e4ea5f3cd1de5fe51c281da4e0eccff3c8a117edbc02b8'
$checksumType32 = 'sha256'
$url64          = 'https://download.kde.org/stable/digikam/7.1.0/digiKam-7.1.0-Win64.exe'
$checksum64     = '51ca55fbf608d42ea5fb81eeca9592a385755a33ab959dcfdf8d1d7151776cf3'
$checksumType64 = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType32" `
                          -url64bit "$url64" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64" `
                          -ValidExitCodes $validExitCodes

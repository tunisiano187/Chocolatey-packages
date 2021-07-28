$ErrorActionPreference = 'Stop'
$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/S'
$url                = 'https://github.com/gramps-project/gramps/releases/download/v5.1.4/GrampsAIO-5.1.4-1_win32.exe'
$checksum           = '33a8feaec3111988fd81cc61715a760c965695a2ea42a1904c666c437b116fcf'
$checksumType       = 'sha256'
$url64              = 'https://github.com/gramps-project/gramps/releases/download/v5.1.4/GrampsAIO-5.1.4-1_win64.exe'
$checksum64         = 'cd18d0d6e6068ac35c9f40c5470649a4998ec5fadf9c2c9f6fd59f33a6b79515'
$checksumType64     = 'sha256'
$validExitCodes     = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -Url64bit "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"

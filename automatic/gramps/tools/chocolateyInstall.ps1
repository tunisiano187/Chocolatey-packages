$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/S'
$url                = 'https://github.com/gramps-project/gramps/releases/download/v5.1.2/GrampsAIO-5.1.2-1_win32.exe'
$checksum           = 'e1a8630cf1ca79b747a51c731bf41a62cee57755da1f2cbc4497220a1ef43bff'
$checksumType       = 'sha256'
$url64              = 'https://github.com/gramps-project/gramps/releases/download/v5.1.2/GrampsAIO-5.1.2-1_win64.exe'
$checksum64         = 'ee12c79b8aca928a53074f0537a1ba10f2decff678d81448aa348612f4eddb9d'
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

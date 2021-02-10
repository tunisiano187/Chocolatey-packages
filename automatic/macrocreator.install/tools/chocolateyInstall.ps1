$packageName = 'macrocreator.install'
$installerType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url = 'https://github.com/Pulover/PuloversMacroCreator/releases/download/v5.4.0/MacroCreator-setup.exe'
$checksum = '32d90b58f94e3e649a04def8ec86654196f3fec069568fbb90f64809f3b3540a'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"

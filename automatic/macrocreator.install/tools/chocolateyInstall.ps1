$packageName = 'macrocreator.install'
$installerType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url = 'https://github.com/Pulover/PuloversMacroCreator/releases/download/v5.4.1/MacroCreator-setup.exe'
$checksum = '92ffa6da0bea664f2499cfbec2a578bf882ed861cbb218b384e6af6ea589dde9'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"

$packageName = 'powderplayer'
$installerType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url = 'https://github.com/jaruba/PowderPlayer/releases/download/v1.20/PowderPlayer_v1.20.exe'
$checksum = '7f365e1455e0a25361495ec428431fbf80a12dca20110ed7263f0ea78d00efc1'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
# generated vars
$packageName = $env:ChocolateyPackageName
$url = 'https://sourceforge.net/projects/pwgen-win/files/latest/download'
$checksum = 'e84c5021e1e46ab371102dc38c04b98b7f02cf697b44ec1c308d40b4cc7ecb5f'

# static vars
$checksumType = 'sha256'
$installerType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)

# $Env:ChocolateyInstall\helpers\functions
Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"

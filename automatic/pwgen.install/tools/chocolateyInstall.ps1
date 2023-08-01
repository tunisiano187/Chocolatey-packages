# generated vars
$packageName = $env:ChocolateyPackageName
$url = 'https://sourceforge.net/projects/pwgen-win/files/latest/download'
$checksum = '1f2b69e69bf45b14759241baba76fa291b4cdbe5821cdd7a0deeebad2ca1bc10'

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

# generated vars
$packageName = $env:ChocolateyPackageName
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.5/PwTech-3.5.5-Setup.exe/download'
$checksum = '6ca475f4ddd0e8ebacf4525748f983bc918a21b8c785b1cb78a925b5bf11e2f1'

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

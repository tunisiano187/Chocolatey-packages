# generated vars
$packageName = $env:ChocolateyPackageName
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.7/PwTech-3.5.7-Setup.exe/download'
$checksum = 'e9d449d9eea32d3d64d274bd5c1ff8940362bb3473ddb11c6a48487d946653e0'

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

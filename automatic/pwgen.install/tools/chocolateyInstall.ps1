# generated vars
$packageName = $env:ChocolateyPackageName
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.6/PwTech-3.5.6-Setup.exe/download'
$checksum = '7ccbb9799e3141e5c377e242a7bb04e5e0671c58b7e59ceb3c192ff33ad8c772'

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

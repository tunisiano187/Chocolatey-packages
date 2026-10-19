# generated vars
$packageName = $env:ChocolateyPackageName
$url = 'https://downloads.sourceforge.net/project/pwgen-win/Password%20Tech/3.6.1/PwTech-3.6.1-Setup.exe'
$checksum = 'AA971B6272DD8197C24929EC57EC6FF220DE3BD123B76FD3E63DB516DD927B22'

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

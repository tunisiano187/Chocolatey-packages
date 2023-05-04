$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$url = 'https://sourceforge.net/projects/freeplane/files/freeplane%20stable/Freeplane-Setup-1.11.1.exe/download'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)
$checksum = 'a85fb999f52798e5b643ce88c14ed17889ba24c102d2726822cb1e5d9b923981'
$checksumType = 'sha256'

Install-ChocolateyPackage -PackageName "$packageName" -FileType "$installerType" -SilentArgs "$silentArgs" -Url "$url" -validExitCodes $validExitCodes -Checksum "$checksum" -ChecksumType "$checksumType"

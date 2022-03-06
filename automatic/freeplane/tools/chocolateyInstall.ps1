$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$url = 'https://sourceforge.net/projects/freeplane/files/freeplane%20stable/Freeplane-Setup-1.9.13.exe/download'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)
$checksum = '1e07a7ceb0a22e942233348c14885f1ecfa6d92a19dbc635db32e66c24823208'
$checksumType = 'sha256'

Install-ChocolateyPackage -PackageName "$packageName" -FileType "$installerType" -SilentArgs "$silentArgs" -Url "$url" -validExitCodes $validExitCodes -Checksum "$checksum" -ChecksumType "$checksumType"

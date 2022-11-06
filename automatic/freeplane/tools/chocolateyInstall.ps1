$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$url = 'https://sourceforge.net/projects/freeplane/files/freeplane%20stable/Freeplane-Setup-with-Java-1.10.3.exe/download'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)
$checksum = 'fd630509ecd6b1bb5adf434b8ec316681b55d354bb5067aee18988fed6b512f6'
$checksumType = 'sha256'

Install-ChocolateyPackage -PackageName "$packageName" -FileType "$installerType" -SilentArgs "$silentArgs" -Url "$url" -validExitCodes $validExitCodes -Checksum "$checksum" -ChecksumType "$checksumType"

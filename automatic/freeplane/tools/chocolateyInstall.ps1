$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$url = 'https://sourceforge.net/projects/freeplane/files/freeplane%20stable/Freeplane-Setup-1.9.14.exe/download'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)
$checksum = '4df94f395840b41a2daaf9098acba49ecd31ba5cc7018226e9871a061fcbcf97'
$checksumType = 'sha256'

Install-ChocolateyPackage -PackageName "$packageName" -FileType "$installerType" -SilentArgs "$silentArgs" -Url "$url" -validExitCodes $validExitCodes -Checksum "$checksum" -ChecksumType "$checksumType"

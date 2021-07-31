$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$url = 'https://sourceforge.net/projects/freeplane/files/freeplane%20stable/Freeplane-Setup-1.9.7.exe/download'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)
$checksum = '2493d0cd818fe754fe470d4bf6d0661538c0774cb08dd6cbdaf06076a65d6395'
$checksumType = 'sha256'

Install-ChocolateyPackage -PackageName "$packageName" -FileType "$installerType" -SilentArgs "$silentArgs" -Url "$url" -validExitCodes $validExitCodes -Checksum "$checksum" -ChecksumType "$checksumType"

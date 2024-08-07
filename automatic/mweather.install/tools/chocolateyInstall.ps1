$packageName = 'mweather.install'
$installerType = 'exe'
$url = 'https://www.nirsoft.net/utils/mweather_setup.exe'
$checksum = '0c7f944ef1458ae1b73b8ef049e10e8a4b6d15b8b8d4c879511656ae5623f74c'
$checksumType = 'sha256'
$silentArgs = '/S'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -Url "$url" `
                          -SilentArgs "$silentArgs" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"

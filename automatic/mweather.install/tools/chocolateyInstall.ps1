$packageName = 'mweather.install'
$installerType = 'exe'
$url = 'https://www.nirsoft.net/utils/mweather_setup.exe'
$checksum = '7a0309adbe58d3cd3035d028429f8de0946a16c32d27fcf770b691817fe089d8'
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

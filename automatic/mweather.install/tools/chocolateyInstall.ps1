$packageName = 'mweather.install'
$installerType = 'exe'
$url = 'https://www.nirsoft.net/utils/mweather_setup.exe'
$checksum = 'c2a219f95955465ce870c973d1ce07635bbe4dd53d8fd643b18117a9745eef00'
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

$packageName = 'mweather.install'
$installerType = 'exe'
$url = 'http://www.nirsoft.net/utils/mweather_setup.exe'
$checksum = '21287df3cc53327e9afcdd0831ba82f9b3314f86168fa9f6ba0f72240782691d'
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
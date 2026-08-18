$packageName = 'mweather.install'
$installerType = 'exe'
$url = 'https://www.nirsoft.net/utils/mweather_setup.exe'
$checksum = 'f9d9bc24d7d1ea1950286e360bcb118a54d6ad065bfc71a090b88ea23036690e'
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

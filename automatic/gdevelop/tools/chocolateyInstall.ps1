$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/S'
$url                = 'https://github.com/4ian/GDevelop/releases/download/v5.3.201/GDevelop-5-Setup-5.3.201.exe'
$checksum           = '72402d9872bcc739065ef3958976640385b7e7a77e875ec7671ccd95286e58fb'
$checksumType       = 'sha256'
$validExitCodes     = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"

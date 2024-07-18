$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/S'
$url                = 'https://github.com/4ian/GDevelop/releases/download/v5.4.205/GDevelop-5-Setup-5.4.205.exe'
$checksum           = '4f1fc71fcf031ef13bfa5a2b79845a254dc8966851b69eb847a87f130dcac255'
$checksumType       = 'sha256'
$validExitCodes     = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"

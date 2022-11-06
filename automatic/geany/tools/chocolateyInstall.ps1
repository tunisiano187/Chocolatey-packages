$packageName = 'geany'
$installerType = 'exe'
$silentArgs = '/S'
$url32 = 'https://github.com/geany/geany/releases/download/1.38.0/geany-1.38_setup.exe'
$checksum32 = '6791f03161d5271f2dc47fff814da713b4ff89fd05c0bec0deb380261c8f8bcf'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType"

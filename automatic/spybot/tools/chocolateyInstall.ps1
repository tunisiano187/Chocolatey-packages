$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/VERYSILENT /NORESTART /SP-'
$url = 'https://updates2.safer-networking.org/spybot1/spybotsd-2.8.68.0.exe'
$checksum = '647cfdf796154ba0ce1786fd72f62102653f6fbfcc982e25da26579b844d966a'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"

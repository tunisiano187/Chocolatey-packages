$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url                = 'https://s3.ap-northeast-2.amazonaws.com/net.xiles.public/download/nexusfile_setup_5.4.1.exe'
$checksum           = 'a76ae2de6ab0e072866133092668af788a7a3d1e664444e7fd7c4b12686ac900'
$checksumType       = 'sha256'
$validExitCodes     = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"

$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '-q -overwrite'
$url            = 'https://salesapi.thebrain.com/?a=doDirectDownload&id=14001'
$checksum       = '3760bd316279218c28359205db4008a02c8d9b9bb8b85c593ebbd06a24f9352e'
$checksumType   = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"

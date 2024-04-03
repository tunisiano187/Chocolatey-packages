$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '-q -overwrite'
$url            = 'https://salesapi.thebrain.com/?a=doDirectDownload&id=70'
$checksum       = 'f4f35883860da32c75fa5637729f142b14476cc775683875b0cae2c3c62dd924'
$checksumType   = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
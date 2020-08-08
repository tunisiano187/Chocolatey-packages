$url32          = ''
$checksum32     = ''
$checksumType32 = ''

$packageArgs = @{
    url             = $url32
    fileType        = 'exe'
    softwareName    = $env:ChocolateyPackageName
    packageName     = $env:ChocolateyPackageName
    silentArgs      = '/verysilent'
    checksum        = $checksum32
    checksumType    = $checksumType32
}
Install-ChocolateyPackage @packageArgs

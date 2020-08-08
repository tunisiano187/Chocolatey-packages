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
    Options = @{
        Headers = @{
            referer = "http://www.1space.dk/executor/download.html"
        }
    }
}
Install-ChocolateyPackage @packageArgs

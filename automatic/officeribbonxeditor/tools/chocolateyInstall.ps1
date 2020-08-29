$url32          = ''
$checksum32     = ''
$checksumType32 = ''

$packageArgs = @{
    packageName            = $env:ChocolateyPackageName
    fileType               = 'EXE'
    url                    = $url32
    checksum               = $checksum32
    checksumType           = $checksumType32
    silentArgs             = '/quiet'
    validExitCodes         = @(0)
}

Install-ChocolateyPackage @packageArgs
Test-Package
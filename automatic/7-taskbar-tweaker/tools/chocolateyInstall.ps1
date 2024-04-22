$url            = 'http://rammichael.com/downloads/7tt_setup.exe'
$checksum       = ''
$checksumType   = ''

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileType      = 'EXE'
    Url           = $url
    checksum      = $checksum
    checksumType  = $checksumType
    softwareName  = 'Arduino*'
    silentArgs    = '/S'
}

Install-ChocolateyPackage @packageArgs

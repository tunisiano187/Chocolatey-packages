$packageName        = $env:ChocolateyPackageName
$silentArgs         = '/S'
$url                = 'http://www.digitalvolcano.co.uk/download/DuplicateCleaner_setup.exe'
$checksum           = ''
$checksumType       = 'md5'
$validExitCodes     = @(0)

$packageArgs = @{
    packageName    = $packageName
    fileType       = 'msi'
    url            = $url
    checksum       = $checksum
    checksumType   = $checksumType
    validExitCodes = $validExitCodes
    SilentArgs     = $silentArgs
}

Install-ChocolateyPackage @packageArgs
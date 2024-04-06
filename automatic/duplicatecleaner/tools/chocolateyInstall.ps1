$packageName        = $env:ChocolateyPackageName
$silentArgs         = "/quiet /qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
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
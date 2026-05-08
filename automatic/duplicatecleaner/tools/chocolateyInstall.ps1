$packageName        = $env:ChocolateyPackageName
$silentArgs         = "/quiet /qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
$url                = 'https://www.digitalvolcano.co.uk/download/DuplicateCleaner-Setup-5.msi'
$checksum           = '432f458a2297e8d2bc5e975f05fdf554be148c15860d2bc0ca1c427f657d9d79'
$checksumType       = 'sha256'
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

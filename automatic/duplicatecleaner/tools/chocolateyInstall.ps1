$packageName        = $env:ChocolateyPackageName
$silentArgs         = "/quiet /qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
$url                = 'https://www.digitalvolcano.co.uk/download/DuplicateCleaner-Setup-5.msi'
$checksum           = 'a094b8832205a8959d423b08cdfbc67fbbb0dffd04913be54f47b78c7f70ec4e'
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

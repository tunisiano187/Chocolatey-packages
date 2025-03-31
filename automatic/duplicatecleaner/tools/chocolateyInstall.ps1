$packageName        = $env:ChocolateyPackageName
$silentArgs         = "/quiet /qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
$url                = 'https://www.digitalvolcano.co.uk/download/DuplicateCleaner-Setup-5.msi'
$checksum           = '52cf63843eb40bdb5c5161bf5d10cbbb00ccf028726976039be61cdc475138e4'
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

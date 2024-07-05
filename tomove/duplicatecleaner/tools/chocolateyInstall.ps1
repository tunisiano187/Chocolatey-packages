$packageName        = $env:ChocolateyPackageName
$silentArgs         = "/quiet /qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
$url                = 'https://www.digitalvolcano.co.uk/download/DuplicateCleaner-Setup-5.msi'
$checksum           = 'c95a74e8fbd4a941496e9b87d553c4ace75585307b5a9a76fe43bc8f9622dc10'
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

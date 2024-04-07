$packageName        = $env:ChocolateyPackageName
$silentArgs         = "/quiet /qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
$url                = 'https://www.digitalvolcano.co.uk/download/DuplicateCleaner-Setup-5.msi'
$checksum           = 'b6bde4771ee22d6940b997a405ff44ffcd7cb068f61cbd09b25249334ecfbaff'
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

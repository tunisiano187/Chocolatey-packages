$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/S'
$url            = 'https://download.litecoin.org/litecoin-0.15.1/win/litecoin-0.15.1-win32-setup.exe'
$checksum       = '97fd13845045475a62e5707ded25d5be75ea1c4d89080418dcba7a670ee46dad'
$checksumType   = 'sha256'
$validExitCodes = @(0)

$packagArgs = @{
    PackageName     = $packageName
    FileType        = $installerType
    SilentArgs      = $silentArgs
    Url             = $url
    checksum        = $checksum
    checksumType    = $checksumType
    ValidExitCodes  = $validExitCodes
}

Install-ChocolateyPackage @packagArgs
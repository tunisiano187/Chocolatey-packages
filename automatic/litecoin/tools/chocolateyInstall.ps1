$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/S'
$url            = 'https://download.litecoin.org/litecoin-0.21.2.2/win/litecoin-0.21.2.2-win64-setup.exe'
$checksum       = 'fe5b2a5f747972940bf4d6eb489c11f3c739bb443168c28b277c0130cc737d35'
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

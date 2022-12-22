$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/S'
$url            = 'https://download.litecoin.org/litecoin-0.21.2.1/win/litecoin-0.21.2.1-win64-setup.exe'
$checksum       = 'd4462b58811bc35c3160c204cc85e94ebe27e57b816ed5bd607f7e22cf3d4131'
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

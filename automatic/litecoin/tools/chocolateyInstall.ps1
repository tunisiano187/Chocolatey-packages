$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/S'
$url            = 'https://download.litecoin.org/litecoin-0.21.3/win/litecoin-0.21.3-win64-setup.exe'
$checksum       = 'fd1d57fd880e1da2f4ef20c3f9d8f2868890ad6cb276c7b765ce8515cf847cd6'
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

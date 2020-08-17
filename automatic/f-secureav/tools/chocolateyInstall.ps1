$url            = 'http://download.sp.f-secure.com/SE/Retail/installer/2/F-SecureNetworkInstaller_AV-ESTORE-TRIAL-GLOBAL_.exe'
$checksum       = ''
$checksumType   = ''

$packageArgs    = @{
    packageName     = $env:ChocolateyPackageName
    fileType        = 'EXE'
    url             = $url
    checksum        = $checksum
    checksumType    = $checksumType
    silentArgs      = '/s'
    validExitCodes  = @(0)
}

Install-ChocolateyPackage $packageArgs
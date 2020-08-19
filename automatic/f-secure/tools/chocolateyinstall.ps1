$ErrorActionPreference = 'Stop'; # stop on all errors
$url            = 'http://download.sp.f-secure.com/SE/Retail/installer/2/F-SecureNetworkInstaller_AV-ESTORE-TRIAL-GLOBAL_.exe'
$checksum       = ''
$checksumType   = ''

$packageArgs    = @{
    PackageName     = $env:ChocolateyPackageName
    FileType        = 'EXE'
    Url             = $url
    Checksum        = $checksum
    ChecksumType    = $checksumType
    SilentArgs      = '/s'
    ValidExitCodes  = @(0)
}

Install-ChocolateyPackage $packageArgs
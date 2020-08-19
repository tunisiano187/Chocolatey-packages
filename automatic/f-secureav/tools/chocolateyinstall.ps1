$ErrorActionPreference = 'Stop'
$url32          = 'https://download.sp.f-secure.com/SE/Retail/installer/F-SecureNetworkInstaller-AV.exe'
$checksum32     = '2b14d4651d3e7e7d6537aecd8ccd608d89aeb55bac82b8f70bee939ca2b925a8'
$checksumType32 = 'sha256'

$packageArgs = @{
    url             = $url32
    fileType        = 'exe'
    softwareName    = $env:ChocolateyPackageName
    packageName     = $env:ChocolateyPackageName
    silentArgs      = '/s'
    checksum        = $checksum32
    checksumType    = $checksumType32
}
Install-ChocolateyPackage @packageArgs

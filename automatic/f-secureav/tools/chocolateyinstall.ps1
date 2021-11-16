$ErrorActionPreference = 'Stop'
$url          = 'https://download.sp.f-secure.com/SE/Retail/installer/F-SecureNetworkInstaller-AV.exe'
$checksum     = ''
$checksumType = ''

$packageArgs = @{
    url             = $url
    fileType        = 'exe'
    softwareName    = $env:ChocolateyPackageName
    packageName     = $env:ChocolateyPackageName
    silentArgs      = '/s'
    checksum        = $checksum
    checksumType    = $checksumType
}

$OSIsServerVersion = if ([Int]3 -eq [Int](Get-CimInstance -Class Win32_OperatingSystem).ProductType) {$True} else {$False}
if($OSIsServerVersion) {
  Write-Warning "System not supported"
  exit 0
} else {
  Install-ChocolateyPackage @packageArgs
}

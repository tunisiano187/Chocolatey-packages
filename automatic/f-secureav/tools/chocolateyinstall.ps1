$ErrorActionPreference = 'Stop'
$url32          = 'https://download.sp.f-secure.com/SE/Retail/installer/F-SecureNetworkInstaller-AV.exe'
$checksum32     = '9edbbfc6936e6fe8347a2132e5c07be7885e5738def0b418a4bf3fbfd9652157'
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

$OSIsServerVersion = if ([Int]3 -eq [Int](Get-CimInstance -Class Win32_OperatingSystem).ProductType) {$True} else {$False}
if($OSIsServerVersion) {
  Write-Warning "System not supported"
  exit 0
} else {
  Install-ChocolateyPackage @packageArgs
}

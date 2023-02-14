$ErrorActionPreference = 'Stop'
$url32          = 'https://download.sp.f-secure.com/SE/Retail/installer/F-SecureNetworkInstaller-AV.exe'
$checksum32     = '85C792F694B83D0B1E195134F782B7DB3E29CE4234BD86F57A99C7D7F260234B'
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

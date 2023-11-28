$url          = 'https://repo.ivpn.net/windows/bin/IVPN-Client-v3.13.3.exe'
$checksum     = 'a3897d2cfa69a4b1457070d9e0732abf01c7c56e3ed555dd3735f7a5b2658756'
$checksumType = 'SHA256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'ivpn*'
  checksum      = $checksum
  checksumType  = $checksumType
  silentArgs   = '/S'
}
$OSIsServerVersion = if ((Get-WmiObject -Class Win32_OperatingSystem).ProductType -ne 1) {$True} else {$False}
if($OSIsServerVersion) {
  Write-Warning "Only runs on Windows Clients (7/8/10/11), does not run on windows servers."
  exit 0
} else {
  Install-ChocolateyPackage @packageArgs
}

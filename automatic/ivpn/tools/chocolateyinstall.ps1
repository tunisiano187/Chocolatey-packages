$url          = 'https://repo.ivpn.net/windows/bin/IVPN-Client-v3.12.0.exe'
$checksum     = '2425f3e339eeb8bb8ac11734b2db918083eea6d2cd9172109e0748b2fcd62f19'
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

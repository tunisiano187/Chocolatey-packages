$url          = 'https://repo.ivpn.net/windows/bin/IVPN-Client-v3.13.1.exe'
$checksum     = 'db921050930eacc678c4d4d3b11f9db78361fd9c72f97b3c6f9fe418774eaa38'
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

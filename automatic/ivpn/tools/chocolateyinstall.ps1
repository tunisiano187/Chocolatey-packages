$url          = 'https://repo.ivpn.net/windows/bin/IVPN-Client-v3.13.4.exe'
$checksum     = '5adc35afa14f582cdad0adba5963cd321d54c56e8065626c705c9eaed0157e47'
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

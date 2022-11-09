$ErrorActionPreference = 'Stop';

$url          = 'https://repo.ivpn.net/windows/bin/IVPN-Client-v3.9.45.exe'
$checksum     = 'e6e3df093c44c83a87cbf538d39983945f9955fadaec3f57a1a23fdfc8fcd678'
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
$OSIsServerVersion = if ([Int]3 -eq [Int](Get-CimInstance -Class Win32_OperatingSystem).ProductType) {$True} else {$False}
if($OSIsServerVersion) {
  Write-Warning "System not supported"
  exit 0
} else {
  $cert = (Get-ChildItem -Include "*.crt" -Recurse).FullName
    CertUtil -AddStore TrustedPublisher ($cert);
  Install-ChocolateyPackage @packageArgs
}

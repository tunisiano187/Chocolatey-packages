$ErrorActionPreference = 'Stop';

$url          = 'https://repo.ivpn.net/windows/bin/IVPN-Client-v3.9.43.exe'
$checksum     = '5bae4107305c33aed8c6c657965317a0a1ba6bf026d244d5da412bc5cccf98ad'
$checksumType = 'sha256'

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

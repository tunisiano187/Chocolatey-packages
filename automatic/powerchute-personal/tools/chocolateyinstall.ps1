$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$url              = 'https://download.schneider-electric.com/files?p_enDocType=Software+-+Released&p_Doc_Ref=APC_PCPE_310&p_File_Name=PCPE_3.1.0.exe'
$checksum         = ''
$checksumType     = ''

$packageArgs = @{
  packageName     = $packageName
  fileType        = 'EXE'
  url             = $url

  softwareName    = '$packageName*'

  checksum        = $checksum
  checksumType    = $checksumType

  validExitCodes  = @(0, 3010, 1641)
  silentArgs      = '/S'
}

$OSIsServerVersion = if ([Int]3 -eq [Int](Get-CimInstance -Class Win32_OperatingSystem).ProductType) {$True} else {$False}
if($OSIsServerVersion) {
  Write-Warning "System not supported"
  exit 0
} else {
  Install-ChocolateyPackage @packageArgs
}

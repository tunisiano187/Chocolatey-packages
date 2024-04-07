$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$url              = 'https://download.schneider-electric.com/files?p_enDocType=Software+-+Released&p_Doc_Ref=APC_PCPE_310&p_File_Name=PCPE_3.1.0.exe'
$checksum         = '06cdb01b2e23ed72452ff090212ba72b5a250c16c41485ecd05d4ac9f75e25ff'
$checksumType     = 'sha256'

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

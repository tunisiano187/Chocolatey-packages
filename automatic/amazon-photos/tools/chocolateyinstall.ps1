$ErrorActionPreference = 'Stop'
$packageName   = 'amazon-photos'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://d29x207vrinatv.cloudfront.net/win/AmazonPhotosSetup.exe'
$checksum      = '47B668F665973B0B4E85B66D389C4204CD26A646ADCE615DED79C5C35713A047'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0)
  silentArgs     = "-quiet"
  softwareName   = 'Amazon Photos'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
Start-Sleep -s 5
Start-WaitandStop "amazonphotos"

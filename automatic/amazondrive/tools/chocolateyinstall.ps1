$ErrorActionPreference = 'Stop'
$packageName   = 'amazondrive'
$url           = 'https://d29x207vrinatv.cloudfront.net/win/AmazonDriveSetup.exe'
$checksum      = 'E9C1C2197A39758447047AFC7C2EB219F918D13440734C1B069CAECF50DE61BA'
$checksumType

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  validExitCodes= @(0)
  silentArgs    = "-quiet"
  softwareName  = 'Amazon Photos'
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyPackage @packageArgs
Start-Sleep -s 5
#Start-CheckandStop "amazondrive"
Start-WaitandStop "amazonphotos"

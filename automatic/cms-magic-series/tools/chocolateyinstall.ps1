$ErrorActionPreference = 'Stop'
$packageName    = 'cms-magic-series'
$installerType  = 'MSI'
$url            = 'https://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS-IPT-2.4.4.2056-win32.msi' 
$checksum       = '00732509B4E8078A2DE7B78613F845C9A121D5DCA236AA262B9219555E3E6ACE'
$checksumType   = 'sha256'
$url64          = 'https://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS-IPT-2.4.4.2056-win64.msi' 
$checksum64     = 'EF6ECA7C367D249CD212E77A48ED6405D64A93D59EBBF48437F9ACB0FF269AED'
$checksumType64 = 'sha256'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'CMS'
  checksum      = $checksum
  checksumType  = $checksumType
  checksum64    = $checksum64
  checksumType64= $checksumType64
}
 
Install-ChocolateyPackage @packageArgs  

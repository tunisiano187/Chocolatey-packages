$ErrorActionPreference = 'Stop'
$packageName   = 'ad-photo-edit-free' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'http://www.cjwdev.com/Software/ADPhotoEdit/ADPhotoEditSetup.zip' 
$UnzippedEXE  = Join-Path $toolsDir 'ADPhotoEditFreeSetup.EXE'
$installerType = 'EXE'
$silentArgs    = '/quiet /qn /norestart'
$validExitCodes= @(0)

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = '470808928DA3EA21504BD9B43A5033719A39019B73A40ADA19612A6127A51735'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$url = $UnzippedEXE

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'exe'
  file          = $UnzippedEXE
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'AD Photo Edit Free Edition*'   
}

Install-ChocolateyInstallPackage @packageArgs						  


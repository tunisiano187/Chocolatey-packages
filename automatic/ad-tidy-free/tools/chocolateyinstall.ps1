$ErrorActionPreference = 'Stop'
$packageName   = 'ad-tidy-free' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'http://www.cjwdev.co.uk/Software/ADTidy/ADTidyInstaller.zip'
$checksum      = '5E32C0FF305F5432AEA62210C60D601620038E0596248583E1118F61F585D45A'
$silentArgs    = '/quiet /norestart'
$validExitCodes= @(0)
$fileLocation  = "$env:ChocolateyInstall\lib\$packageName\tools\ADTidyFreeInstaller.exe"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'AD Tidy Free Edition*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$env:ChocolateyInstall\lib\$packageName\tools\ADTidyFreeInstaller.exe"
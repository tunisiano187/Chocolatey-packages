$ErrorActionPreference = 'Stop'
$packageName    = 'pcmark8'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://akamai-dl.futuremark.com.akamaized.net/PCMark8-v2-10-901.zip'
$checksum       = '5CA0578BCF55671C2F8A1BCEF767A88A687091099354E01901D418D4570547BA'
$silentArgs     = '/S'
$validExitCodes = @(0)
$fileLocation   = "$env:ChocolateyInstall\lib\pcmark8\tools\PCMark8-setup.exe"

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
  softwareName  = 'PCMark*'
}

Install-ChocolateyInstallPackage @packageArgs

Start-CheckandStop "FMSISvc"

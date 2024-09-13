$ErrorActionPreference = 'Stop'
$packageName    = 'realtek-hd-audio-driver' 
$global:packageMaintainer = 'BCURRAN3'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://realtek-download.com/wp-content/uploads/2017/08/0009-32bit_Win7_Win8_Win81_Win10_R282.exe'
$checksum       = '4DBEB838B2E6650D0B57F0DB6EABE0DD8445A144DC64E3B38E3DF39BE1D41DAD'
$url64          = 'https://realtek-download.com/wp-content/uploads/2017/08/0009-64bit_Win7_Win8_Win81_Win10_R282.exe'
$checksum64     = '09784AB2BDFE97EEB085985B0C8A9E9727E882450B7918990B057B62612B967B'
$silentArgs     = '/S'
$validExitCodes = @(0)
$extractDir     = "$toolsDir\extracted"
$fileLocation   = "$extractDir\setup.exe"


$card = wmic path Win32_SoundDevice get name
if ($card -match "Realtek")
  {
   write-host "You've got $card!" -foreground "green" –backgroundcolor "blue"
  } else {
   write-host "No Realtek audio hardware found. Aborting." -foreground "red" –backgroundcolor "blue"
   throw
   }
   
New-Item $extractDir -type directory   

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $extractDir 
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'Realtek*'
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $extractDir -recurse| out-null

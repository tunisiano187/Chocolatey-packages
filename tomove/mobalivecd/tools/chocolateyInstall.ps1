$toolsDir     = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url          = 'https://www.mobatek.net/exes/MobaLiveCD_v2.1.exe'
$checksum     = 'ddb4adf5dff5656673bf90e37ff397cb0736c68225ae8f4d17ee17f83c723994'
$checksumType = 'sha256'

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  url             = $url
  checksum        = $checksum
  checksumType    = $checksumType
  FileFullPath    = "${toolsDir}\MobaLiveCD_v2.1.exe"
}

Get-ChocolateyWebFile @packageArgs
Install-ChocolateyShortcut -ShortcutFilePath "$($env:USERPROFILE)\Desktop\$($env:ChocolateyPackageName).lnk" -TargetPath "${toolsDir}\MobaLiveCD_v2.1.exe"

$packageName    = 'autobootdisk'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.simpodex.com/autobootdisk5.7.msi' 
$checksum       = 'D278F23B202A16E38528063EA1649A8E20610F480BC7EA300F8B9CA99A3A8551'
$silentArgs     = '/quiet /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'AutoBootDisk'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  

$packageName    = 'bzflag'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://download.bzflag.org/bzflag/windows/2.4.10/bzflag-2.4.10.exe' 
$checksum       = 'A33119ABACF6B896E523C777BBF918D042D8618BE9DBF0369644FB49009F2ECF'
$checksumType   = 'sha256'
$silentArgs     = '/S'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'BZFlag*'
  checksum      = $checksum 
  checksumType  = $checksumType
}

Install-ChocolateyPackage @packageArgs  
  

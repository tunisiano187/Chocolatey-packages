$ErrorActionPreference = 'Stop'
$packageName= 'softsqueeze' 
$url        = 'https://sourceforge.net/projects/softsqueeze/files/softsqueeze/softsqueeze-3.9b2/softsqueeze_3.9b2.zip'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = 'D0F3BFE578EEA3B6D79BDDBFD4C2E422A36A847302AB887C77D872D87F913C5C'
  checksumType  = 'sha256'    
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Softsqueeze.lnk" -targetPath "$toolsDir\SoftSqueeze.jar"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Softsqueeze.lnk" -targetPath "$toolsDir\SoftSqueeze.jar"
$packageName  = 'ubooquity'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://vaemendis.net/ubooquity/downloads/Ubooquity-3.1.0.zip'
$checksum     = 'a9db701e6ee71d834d09e05f724e4f1c577432c0782f31119e43a06f0d874b6b'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Ubooquity.lnk" -targetPath "$toolsDir\Ubooquity.jar" -WorkingDirectory $toolsDir -IconLocation "$toolsDir\ubooquity.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Ubooquity.lnk" -targetPath "$toolsDir\Ubooquity.jar" -WorkingDirectory $toolsDir -IconLocation "$toolsDir\ubooquity.ico"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null

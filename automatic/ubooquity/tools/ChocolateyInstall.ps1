$packageName  = 'ubooquity' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://vaemendis.net/ubooquity/downloads/Ubooquity-2.1.2.zip'
$checksum     = 'D880955B1CB5635BE70F7A9D4FFDD1CAB4F528683E9FC7E978B6E3658A69024C'
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

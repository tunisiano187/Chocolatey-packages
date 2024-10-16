$packageName  = 'ubooquity'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://stompsoftware.com/downloadfiles/albumstomp/SetupAlbumStompV2.exe'
$checksum     = 'e6da1083635df601b5eb841de879a2286efef0982bc4d9c3183f4f2126fd0a9c'
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

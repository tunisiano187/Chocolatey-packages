$packageName  = 'urban-terror' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://cdn.urbanterror.info/urt/43/releases/zips/UrbanTerror434_full.zip'
$checksum     = '716669CC6C525663B791852E51FF9C94D96F382BE39279DAB6084DDDACB5A4E7'
$shortcutName = 'Urban Terror.lnk'
$exe          = 'UrbanTerror43\Quake3-UrT.exe'


$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Write-Warning "  ** This download can take a while even on a fast connection!" 
Install-ChocolateyZipPackage @packageArgs

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\UrbanTerror43"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\UrbanTerror43"


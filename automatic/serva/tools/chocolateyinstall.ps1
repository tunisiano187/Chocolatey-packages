$ErrorActionPreference = 'Stop'
$packageName = 'serva' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://www.vercot.com/~serva/download/Serva_Community_v4.6.0-21120715.zip'
$checksum    = 'FF470757BAC7A596E7CF9D5FB42953BDA1F454ED409F62CEF6E02B571C31058B'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksumType  = 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs

if (Get-ProcessorBits 64) {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Serva.lnk" -targetPath "$toolsDir\Serva64.exe" -WorkingDirectory "$toolsDir"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Serva.lnk" -targetPath "$toolsDir\Serva64.exe" -WorkingDirectory "$toolsDir"
  } else {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Serva.lnk" -targetPath "$toolsDir\Serva32.exe" -WorkingDirectory "$toolsDir"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Serva.lnk" -targetPath "$toolsDir\Serva32.exe" -WorkingDirectory "$toolsDir"
  }
  
$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | Out-Null

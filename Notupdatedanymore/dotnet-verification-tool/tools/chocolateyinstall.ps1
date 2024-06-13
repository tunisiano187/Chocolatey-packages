$ErrorActionPreference = 'Stop'
$packageName    = 'dotnet-verification-tool'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://msdnshared.blob.core.windows.net/media/MSDNBlogsFS/prod.evol.blogs.msdn.com/CommunityServer.Components.PostAttachments/00/08/99/90/04/netfx_setupverifier_new_2015_12_18.zip'
$checksum       = '360D78D359F54C09A87CBB044D83E6ADD256AFD14DA278FE023BE59237F9486C'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\dotNET Framework Setup Verification Tool.lnk" -targetPath "$toolsDir\netfx_setupverifier.exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\dotNET Framework Setup Verification Tool.lnk" -targetPath "$toolsDir\netfx_setupverifier.exe" -WorkingDirectory "$toolsDir"

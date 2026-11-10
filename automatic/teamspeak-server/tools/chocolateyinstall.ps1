$ErrorActionPreference = 'Stop'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32        = 'https://files.teamspeak-services.com/releases/server/3.13.9/teamspeak3-server_win32-3.13.9.zip'
$checksum32   = 'E620A6EFEDBEACAA68AB438FFDA0DCB8C24D0EBCE0CD96847902EFC772A253A4'
$url64        = 'https://files.teamspeak-services.com/releases/server/3.13.9/teamspeak3-server_win64-3.13.9.zip'
$checksum64   = '0886B75139A1C61278D1747555D5793BF49AF37FF414228DF605B0DEA4C76A39'
$checksumType = 'sha256'
$shortcutName = 'TeamSpeak Server.lnk'
$exe          = 'ts3server.exe'

if ((Get-OSArchitectureWidth -eq 64) -and ($env:chocolateyForceX86 -ne $true))
    {
     $workingDir = 'teamspeak3-server_win64'
    } else {
     $workingDir = 'teamspeak3-server_win32'
    }

$packageArgs = @{
  packageName    = 'teamspeak-server'
  unzipLocation  = $toolsDir
  fileType       = 'ZIP'
  url            = $url32
  checksum       = $checksum32
  checksumType   = $checksumType
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = $checksumType
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$workingDir\$exe" -WorkingDirectory "$toolsDir\$workingDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$workingDir\$exe" -WorkingDirectory "$toolsDir\$workingDir"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null

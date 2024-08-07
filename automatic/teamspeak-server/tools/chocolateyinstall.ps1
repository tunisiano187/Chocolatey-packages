$ErrorActionPreference = 'Stop'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32        = 'https://files.teamspeak-services.com/releases/server/3.13.7/teamspeak3-server_win32-3.13.7.zip'
$checksum32   = '03EC18E7700D0884D09E6CBB9419CC8EA80736BF5AC82582941BBE8DC81F3D52'
$url64        = 'https://files.teamspeak-services.com/releases/server/3.13.7/teamspeak3-server_win64-3.13.7.zip'
$checksum64   = '489F6F02B336F80812AD0307897E072C37042D1C39341E4EFBE7C09D1E100F59'
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

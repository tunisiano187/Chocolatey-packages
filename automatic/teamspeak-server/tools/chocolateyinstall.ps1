$ErrorActionPreference = 'Stop'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32        = 'https://files.teamspeak-services.com/releases/server/3.13.6/teamspeak3-server_win32-3.13.6.zip'
$checksum32   = 'f52cddfd2f1297756afa12d758718b3ee34b88c0e7962fb75985877f480e0d71'
$url64        = 'https://files.teamspeak-services.com/releases/server/3.13.6/teamspeak3-server_win64-3.13.6.zip'
$checksum64   = '6ffe2fad26cd68cbd8c23f7361469f7eaba9b267f320daf9cce90ed28e4b3bca'
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

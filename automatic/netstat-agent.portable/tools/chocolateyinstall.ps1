$ErrorActionPreference = 'Stop'

$packageName= 'netstat-agent.portable' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://netstatagent.com/files/netagent-portable.zip' 
$ExeFile    = 'NetAgent.exe'
$ShortcutName = 'NetStat Agent'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'NetStat Agent*' 
  checksum      = 'BAE4119A62287973DB8C60646B12B42FC61304B987D3B0E3122809872F6B23FF'
  checksumType  = 'sha256'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\netagent-portable\$ExeFile"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\netagent-portable\$ExeFile" -WorkingDirectory "$toolsDir"
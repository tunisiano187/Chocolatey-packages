$packageName  = 'pytivo-wmcbrine' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/wmcbrine/pytivo/archive/master.zip'
$checksum     = 'B7AAFF318F2D7471CC550ADB11FBF89AC333FFB4C559F7E3F48611D40D870387'
$ShortcutName = 'PyTiVo (wmcbrine).lnk'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'   
}

Install-ChocolateyZipPackage @packageArgs

$WhoAmI=whoami
$Acl = Get-Acl "$toolsDir\pytivo-master"
$Ar = New-Object  system.security.accesscontrol.filesystemaccessrule($WhoAmI,"FullControl","Allow")
$Acl.SetAccessRule($Ar)
Set-Acl "$toolsDir\pytivo-master" $Acl

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\pytivo-master\pytivo.py" -iconLocation "$env:ChocolateyInstall\lib\$packageName\tools\pytivo.ico" -workingDirectory "$env:ChocolateyInstall\lib\$packageName\tools\pytivo-master\"

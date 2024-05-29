$ErrorActionPreference = 'Stop'
$packageName  = 'ad-acl-scanner'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName     = 'ADACLScan.ps1'
$shortcutName = 'AD ACL Scanner'
$FileFullpath = "$toolsDir\$fileName"

Install-ChocolateyShortcut -shortcutFilePath "$ENV:USERPROFILE\Desktop\$shortcutName.lnk" -targetPath $FileFullpath -WorkingDirectory "$toolsDir"


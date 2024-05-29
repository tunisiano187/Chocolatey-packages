$ErrorActionPreference = 'Stop'
$packageName  = 'ad-acl-scanner'
$shortcutName = 'AD ACL Scanner'

Remove-Item "$ENV:USERPROFILE\Desktop\$shortcutName.lnk" -Force -ErrorAction SilentlyContinue

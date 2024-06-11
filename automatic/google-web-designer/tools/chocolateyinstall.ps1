$ErrorActionPreference = 'Stop'
$packageName    = 'google-web-designer' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/tag/s/appguid%3D%7B811767F4-C586-4673-A41F-E9D767497222%7D%26iid%3D%7B76F7D27F-79FA-5312-EC6D-85B3F7CB2411%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Web%2520Designer%26needsadmin%3DTrue/webdesigner/win/shell/googlewebdesigner_win.exe'
$validExitCodes = @(0)

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'exe' 
  url            = $url
  silentArgs     = '' 
  softwareName   = 'Google Web Designer*'
  checksum       = $checksum
  checksumType   = 'sha256'  
  validExitCodes = $validExitCodes
  }
  
Install-ChocolateyPackage @packageArgs

Start-Sleep -s 10
Start-CheckandStop "webdesigner"

$ErrorActionPreference = 'Stop'
$packageName = 'unifying' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://download01.logi.com/web/ftp/pub/techsupport/unifying/unifying252.exe'
$checksum    = 'BEA2CA4C9D9ABD1FF214166D638792BE974FFAD7907A8A8ED0370ACBA800E815'
$silentArgs  = '/S' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'    
  silentArgs    = $silentArgs
  softwareName  = 'Logitech Unifying Software*' 
  }
  
Install-ChocolateyPackage @packageArgs

Start-Sleep -s 2
if((get-process "DJCUHost" -ea SilentlyContinue) -eq $Null){ 
        echo "DJCUHost not running... (Good!)" 
}
else{ 
    echo "Stopping DJCUHost post install..."
    Stop-Process -processname "DJCUHost"
 }

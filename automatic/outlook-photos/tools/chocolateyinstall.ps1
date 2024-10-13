$ErrorActionPreference = 'Stop'
$packageName= 'outlook-photos'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download-outlook-photos.exclaimer.com/Setup.exe'
$checksum   = 'C722359A75A158FE514D7578D31F0289062C97864E58E5C31A4AC305711004FA'
$silentArgs = '/quiet /norestart'
$validExitCodes= @(0, 3010, 1641)
$fileLocation = "$env:ChocolateyInstall\lib\$packageName\tools\Outlook Photos Install.msi"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'Exclaimer Outlook Photos*'
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$env:ChocolateyInstall\lib\$packageName\tools\Outlook Photos Install.msi"
Remove-Item "$env:ChocolateyInstall\lib\$packageName\tools\Bootstrapper_Install.bat"

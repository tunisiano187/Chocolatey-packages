# download page without login - https://realvnc.com/en/connect/download/vnc/
$ErrorActionPreference = 'Stop'
$packageName    = 'vnc-connect'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$extractDir     = "$toolsDir\extracted"
$url            = 'https://downloads.realvnc.com/download/file/vnc.files/VNC-Server-7.16.0-Windows-msi.zip'
$checksum       = '37198fb696d1babc5dac0691aa95247edaccf8a06a597f344f989626af0e6dd7'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $extractDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs

if ($bits -eq 64)
   {
    $Installer = (Get-ChildItem -Path $extractDir -Filter "*64bit.msi").FullName
   } else {
    $Installer = (Get-ChildItem -Path $extractDir -Filter "*32bit.msi").FullName
   }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  file           = "$Installer"
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'VNC Server*'
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $extractDir -Recurse -Force | Out-Null

# download page without login - https://realvnc.com/en/connect/download/vnc/
$ErrorActionPreference = 'Stop'
$packageName    = 'vnc-connect'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$extractDir     = "$toolsDir\extracted"
$url            = 'https://downloads.realvnc.com/download/file/vnc.files/VNC-Server-7.12.0-Windows-msi.zip'
$checksum       = 'dde6cb92dc5359ef566b4f72e4241b4ec66062a1d673cc132d0f3502612b3150'
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

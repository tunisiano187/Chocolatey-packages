# download page without login - https://realvnc.com/en/connect/download/vnc/
$ErrorActionPreference = 'Stop'
$packageName    = 'vnc-connect'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$extractDir     = "$toolsDir\extracted"
$url            = 'https://downloads.realvnc.com/download/file/vnc.files/VNC-Server-$env:ChocolateyPackageVersion-Windows-msi.zip'
$checksum       = '225A601E9BBE5A1B32892FF6EF96787D19E44F5A8E667138B40BAA6024B2B621'
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
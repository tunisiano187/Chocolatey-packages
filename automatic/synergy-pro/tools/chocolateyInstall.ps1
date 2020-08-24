$ErrorActionPreference = 'Stop'

$url32            = ''
$url64            = ''
$checksum32       = ''
$checksum64       = ''
$checksumType32   = ''
$checksumType64   = ''

$InstallArgs = @{
   packageName    = $env:ChocolateyPackageName
   fileType       = 'msi'
   url            = $url32
   url64bit       = $url64
   Checksum       = $checksum32
   ChecksumType   = $checksum64
   Checksum64     = $checksumType32
   ChecksumType64 = $checksumType64
   silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
   validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @InstallArgs
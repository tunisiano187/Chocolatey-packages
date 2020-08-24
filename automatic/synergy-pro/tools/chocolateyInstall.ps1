$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$InstallArgs = @{
   packageName    = $env:ChocolateyPackageName
   fileType       = 'msi'
   url            = ''
   url64bit       = ''
   Checksum       = ''
   ChecksumType   = ''
   Checksum64     = ''
   ChecksumType64 = ''
   silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
   validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @InstallArgs




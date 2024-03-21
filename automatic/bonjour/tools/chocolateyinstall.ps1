$ErrorActionPreference = 'Stop';

$checksum = '0b3d970ecdcc431465f623a16f7b4fdf4e7baee335a2dc1e36c0602f97d81be0'
$checksumType = 'sha256'

$checksum64 = '0b3d970ecdcc431465f623a16f7b4fdf4e7baee335a2dc1e36c0602f97d81be0'
$checksumType64 = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType		= "msi"

  url           = 'http://sdupdt.itsupport247.net/tpupdate/Bonjour_3.1.0.1.msi'
  checksum      = $checksum
  checksumType  = $checksumType

  url64bit      = 'http://sdupdt.itsupport247.net/tpupdate/Bonjour64_3.1.0.1.msi'
  checksum64    = $checksum64
  checksumType64= $checksumType64

  silentArgs	= "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-ChocolateyPackage @packageArgs

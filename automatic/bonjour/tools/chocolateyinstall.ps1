$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType		= "msi"

  url           = 'http://sdupdt.itsupport247.net/tpupdate/Bonjour_3.1.0.1.msi'
  checksum      = '7d7b2986d4fd35cc98af3607b1a5e2e004d6ab1116a4a9db37a66c17b63b6397'
  checksumType  = 'sha256'

  url64bit      = 'http://sdupdt.itsupport247.net/tpupdate/Bonjour64_3.1.0.1.msi'
  checksum64    = '46e31e284da64d6c2d366352b8a8abcf7db28d3e2a870d8fcf15c4a6fe0a6dd1'
  checksumType64= 'sha256'

  silentArgs	= "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-ChocolateyPackage @packageArgs

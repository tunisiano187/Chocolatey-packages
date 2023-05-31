$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  fileType		    = "exe"

  url             = 'http://sdupdt.itsupport247.net/tpupdate/Bonjour64_3.1.0.1.msi'
  checksum        = '46e31e284da64d6c2d366352b8a8abcf7db28d3e2a870d8fcf15c4a6fe0a6dd1'
  checksumType64  = 'sha256'

  silentArgs	    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-ChocolateyPackage @packageArgs

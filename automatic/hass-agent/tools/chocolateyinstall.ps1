$ErrorActionPreference = 'Stop';
$url          = ''
$checksumType = ''
$checksum     = ''

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  fileType		    = "exe"

  url             = $url
  checksum        = $checksum
  checksumType    = $checksumType

  silentArgs	    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-ChocolateyPackage @packageArgs

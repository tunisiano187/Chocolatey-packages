$ErrorActionPreference = 'Stop';

$packageName    = "${ENV:ChocolateyPackageName}"
$packageTitle   = "${ENV:ChocolateyPackageTitle}"
$url64          = "https://github.com/mesonbuild/meson/releases/download/${ENV:ChocolateyPackageVersion}/meson-${ENV:ChocolateyPackageVersion}-64.msi"
$checksum64     = ""
$checksumType64 = ""
$silentArgs     = "/qn /norestart /l*v `"$(${ENV:TEMP})\$(${packageName}).$(${ENV:chocolateyPackageVersion}).MsiInstall.log`""

$packageArgs = @{
  packageName     = $packageName
  softwareName    = $packageTitle
  url64           = $url64
  fileType        = "msi"
  silentArgs      = $silentArgs
  validExitCodes  = @(0)
  checksum64      = $checksum64
  checksumType64  = $checksumType64
}

Install-ChocolateyPackage @packageArgs


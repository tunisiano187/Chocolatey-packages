$ErrorActionPreference = 'Stop';

$packageName    = "${ENV:ChocolateyPackageName}"
$packageTitle   = "${ENV:ChocolateyPackageTitle}"
$url64          = "https://github.com/mesonbuild/meson/releases/download/${ENV:ChocolateyPackageVersion}/meson-${ENV:ChocolateyPackageVersion}-64.msi"
$silentArgs     = "/qn /norestart /l*v `"$(${ENV:TEMP})\$(${packageName}).$(${ENV:chocolateyPackageVersion}).MsiInstall.log`""

$packageArgs = @{
  packageName     = "${packageName}"
  softwareName    = "${packageTitle}"
  url64           = "${url64}"
  fileType        = "msi"
  silentArgs      = "${silentArgs}"
  validExitCodes  = @(0)
  checksum64      = "1de449d672e7b66ee8ef646e8b06f6ce323ce671f31cba751a3e79cf3c59d3e3"
  checksumType64  = "sha256"
}

Install-ChocolateyPackage @packageArgs

Write-Output ""

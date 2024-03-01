$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64          = 'https://1111-releases.cloudflareclient.com/windows/Cloudflare_WARP_Release-x64.msi'
$checksum64     = '34421E7C28434BF3BE9A1B1D5AC169DFB2B79720E1CCD7755871776AE1CFE913F9A3A7FA66187A07CACEEF62F14BA05A43B9426C5FB355C4839A83210DC5EB24'
$checksumType64 = 'SHA512'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url64bit      = $url64

  softwareName  = 'warp*'

  checksum64    = $Checksum64
  checksumType64= $ChecksumType64

  # MSI
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes= @(0, 3010, 1641)
}

if([System.Environment]::OSVersion.Version -ge ([version]"10.0.18363")) {
  Install-ChocolateyPackage @packageArgs
} else {
  Write-Warning "System not supported, 1909+ required"
  exit 0;
}

$ErrorActionPreference = 'Stop';
$pp             = Get-PackageParameters
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64          = 'https://1111-releases.cloudflareclient.com/windows/Cloudflare_WARP_Release-x64.msi'
$checksum64     = '0282BFB2C2707F6A68046FEEAD475BEF72408521BB3528E79AE79B3D3E9779B1F2B11BCE81799002216CA57C57027041971D4D4B9515C64FC92749E1722CD2BA'
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

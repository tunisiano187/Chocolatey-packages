$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64          = 'https://1.1.1.1/Cloudflare_WARP_Release-x64.msi'
$checksum64     = 'B3DDE8509A6892EC46CE8711F1FFFF4E1054AEF3376B8006CB4DC8C040AAB0B0F0EFC5ED5F36BEB7402AED739E3A92E4EC5B7AC1A0BA8627870E0E2075E47288'
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

$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64          = 'https://1.1.1.1/Cloudflare_WARP_Release-x64.msi'
$checksum64     = '249C5E7F3853048217B89280C29AB30EE6F31B8490CE698FB833617BB63B8362EE1F937E464CDC78E6B038E7D1F6DE80D1A038E6ADEB7B0B2EBB0D8FFDDB9C57'
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

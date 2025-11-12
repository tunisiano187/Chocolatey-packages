$ErrorActionPreference = 'Stop';
$pp             = Get-PackageParameters
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64          = 'https://1111-releases.cloudflareclient.com/windows/Cloudflare_WARP_Release-x64.msi'
$checksum64     = 'AC519BCC2937D93D67D31497D72A6262801D30CEA98894A9584C0B92D0635BA2'
$checksumType64 = 'sha256'

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

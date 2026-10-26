$ErrorActionPreference = 'Stop';
$pp             = Get-PackageParameters
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64          = 'https://1111-releases.cloudflareclient.com/windows/Cloudflare_WARP_Release-x64.msi'
$checksum64     = 'AB3138DBEBDF132AF076B5EBCB25B42345D29258ACB76267C3BD1F8CFEA57A53'
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

$OSVersion = [version](Get-CimInstance Win32_OperatingSystem).Version

Write-Host "Detected Windows Version: $OSVersion"

if ($OSVersion -ge [version]"10.0.18363") {
    Install-ChocolateyPackage @packageArgs
}
else {
    Write-Warning "System not supported, 1909+ required. Detected version: $OSVersion"
    exit 1
}

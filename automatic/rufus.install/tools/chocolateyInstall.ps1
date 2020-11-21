$ErrorActionPreference = 'Stop';

$WindowsVersion=[Environment]::OSVersion.Version
if ($WindowsVersion.Major -ne "10") {
  Write-Warning "This package requires Windows 10."
  exit 0
}

$AppxPackageName  = "Rufus"
$version          = '3.13'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName         = "$toolsDir\Rufus-$version.appx"

# Allow package outside appstore
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
$Name1 = "AllowAllTrustedApps"
$value1 = "1"
New-ItemProperty -Path $registryPath -Name $name1 -Value $value1 -PropertyType DWORD -Force

$Name2 = "AllowDevelopmentWithoutDevLicense"
$value2 = "0"
New-ItemProperty -Path $registryPath -Name $name2 -Value $value2 -PropertyType DWORD -Force

if ((Get-AppxPackage -name $AppxPackageName).Version -Match $version) {
  if($env:ChocolateyForce) {
    # you can't install the same version of an appx package, you need to remove it first
    Write-Output "Removing already installed version first."
    Get-AppxPackage -Name Rufus | Remove-AppxPackage
  } else {
    Write-Output "The $version version of Rufus is already installed. If you want to reinstall use --force"
    return
  }
}

Add-AppxPackage -Path $fileName

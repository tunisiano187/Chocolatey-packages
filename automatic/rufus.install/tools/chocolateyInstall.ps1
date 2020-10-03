$ErrorActionPreference = 'Stop';

$WindowsVersion=[Environment]::OSVersion.Version
if ($WindowsVersion.Major -ne "10") {
  Write-Warning "This package requires Windows 10."
  exit 0
}

$AppxPackageName = "Rufus"
$version        = '3.11.1678.0'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName       = "$toolsDir\Rufus-$version.appxbundle"

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
$ErrorActionPreference = 'Stop';

$packageName    = 'bonjour'
#$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://support.apple.com/downloads/DL999/en_US/BonjourPSSetup.exe'
$checksum       = '847f39e0ea80d2a4d902fe59657e18f5bc32a8cb'
$checksumType   = 'sha1'
$url64          = 'https://support.apple.com/downloads/DL999/en_US/BonjourPSSetup.exe'
$checksum64     = '847f39e0ea80d2a4d902fe59657e18f5bc32a8cb'
$checksumType64 = 'sha1'
$fileType       = 'msi'
$silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
$validExitCodes = @(0, 3010, 1641)
$file = "$env:temp\Bonjour.msi"

if (Get-ProcessorBits -eq 64) {
	$url = $url64
	$checksum = $checksum64
	$checksumType = $checksumType64
	$file = "$env:temp\Bonjour64.msi"
}

&(Get-ChocolateyWebFile $packageName "$env:temp\BonjourPSSetup.exe" $url -Checksum $checksum -ChecksumType $checksumType) /extract $env:temp
Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes
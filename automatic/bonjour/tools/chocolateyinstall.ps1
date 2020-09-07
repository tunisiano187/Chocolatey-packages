$ErrorActionPreference = 'Stop';

$packageName    = 'bonjour'
#$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Package download informations
$url            = 'https://support.apple.com/downloads/DL999/en_US/BonjourPSSetup.exe'
$checksum       = '7f1ec347cd429cfb25a34b2147e02231334f28290e0c28be213415b0f99da1a0'
$checksumType   = 'sha256'

# Installer informations (contained in the exe package)
$fileType       = 'msi'
$silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
$validExitCodes = @(0, 3010, 1641)

# Installer selection
$file = "$env:temp\Bonjour.msi"
if (Get-ProcessorBits -eq 64) {
	$file = "$env:temp\Bonjour64.msi"
}

# Downloading package and unzipping it
&(Get-ChocolateyWebFile $packageName "$env:temp\BonjourPSSetup.exe" $url -Checksum $checksum -ChecksumType $checksumType) /extract $env:temp

# Installing from the extracted msi
Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes
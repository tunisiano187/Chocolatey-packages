$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName = 'hp-bios-cmdlets'
$url = 'https://downloads.hpe.com/pub/softlib2/software1/pubsw-windows/p2008826436/v125061/HPBIOSCmdlets-x86.exe'
$url64 = 'https://downloads.hpe.com/pub/softlib2/software1/pubsw-windows/p230763598/v125062/HPBIOSCmdlets-x64.exe'
$checksum = 'BF8961521330F0157406756ACEF0160FC47245F7DA29BCDEB194E12F56445A86'
$checksum64 = '3F52A381E4851BEC6BC2FAA619D15B695A2C59A5C62B3C75F1F37FBA17C0BC9C'
$checksumType = 'sha256'
$checksumType64 = 'sha256'
$fileType = 'msi'
$silentArgs = '/quiet'
$dlPkg = "$packageName" + ".exe"
$ValidExitCodes = '0'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

if (Get-ProcessorBits 64) {
    $file = "HPBIOSCmdlets-x64.msi"
} else {
    $file = "HPBIOSCmdlets-x86.msi"
}

Get-ChocolateyWebFile -PackageName $packageName -FileFullPath "$toolsDir\$dlPkg" -Url $url -Url64 $url64 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64
Get-ChocolateyUnzip -FileFullPath "$toolsDir\$dlPkg" -Destination $toolsDir 
Install-ChocolateyInstallPackage $packageName $fileType $silentArgs "$toolsDir\$file" -ValidExitCodes $ValidExitCodes

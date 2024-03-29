$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName = 'hp-ilo-cmdlets'
$url = 'https://downloads.hpe.com/pub/softlib2/software1/pubsw-windows/p1086382174/v125609/HPiLOCmdlets-x86.exe'
$url64 = 'https://downloads.hpe.com/pub/softlib2/software1/pubsw-windows/p2102165468/v125608/HPiLOCmdlets-x64.exe'
$checksum = '40C4DA14B9B32165E74A3B79A222912185092C2C47E13AECF83645FABC6A2D76'
$checksum64 = '6C1B707E19C9A2A7B44F304CB82FD540ED1780CF56031615A222FB89EB0ED2A7'
$checksumType = 'sha256'
$checksumType64 = 'sha256'
$fileType = 'msi'
$silentArgs = '/quiet'
$dlPkg = "$packageName" + ".exe"
$ValidExitCodes = '0'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

if (Get-ProcessorBits 64) {
    $file = "HPILOCmdlets-x64.msi"
} else {
    $file = "HPILOCmdlets-x86.msi"
}

Get-ChocolateyWebFile -PackageName $packageName -FileFullPath "$toolsDir\$dlPkg" -Url $url -Url64 $url64 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64
Get-ChocolateyUnzip -FileFullPath "$toolsDir\$dlPkg" -Destination $toolsDir 
Install-ChocolateyInstallPackage $packageName $fileType $silentArgs "$toolsDir\$file" -ValidExitCodes $ValidExitCodes

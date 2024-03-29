$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName = 'hp-oa-cmdlets'
$url = 'https://downloads.hpe.com/pub/softlib2/software1/pubsw-windows/p157797746/v125056/HPOACmdlets-x86.exe'
$url64 = 'https://downloads.hpe.com/pub/softlib2/software1/pubsw-windows/p667675183/v125054/HPOACmdlets-x64.exe'
$checksum = 'FB9205CBB3477F3A0E9DBD56A7DAAE54A38ED84A52D80FEA5E44AD0BF105B56A'
$checksum64 = 'A66D300920464A8A7F9BF11E554E88C136180B28E66AF46F48674CFBB166AB81'
$checksumType = 'sha256'
$checksumType64 = 'sha256'
$fileType = 'msi'
$silentArgs = '/quiet'
$dlPkg = "$packageName" + ".exe"
$ValidExitCodes = '0'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

if (Get-ProcessorBits 64) {
    $file = "HPOACmdlets-x64.msi"
} else {
    $file = "HPOACmdlets-x86.msi"
}

Get-ChocolateyWebFile -PackageName $packageName -FileFullPath "$toolsDir\$dlPkg" -Url $url -Url64 $url64 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64
Get-ChocolateyUnzip -FileFullPath "$toolsDir\$dlPkg" -Destination $toolsDir 
Install-ChocolateyInstallPackage $packageName $fileType $silentArgs "$toolsDir\$file" -ValidExitCodes $ValidExitCodes

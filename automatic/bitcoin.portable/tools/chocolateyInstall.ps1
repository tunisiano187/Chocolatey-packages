$packageName = $env:ChocolateyPackageName
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://github.com//bitcoin/bitcoin/archive/v0.21.0rc3.zip'
$checksum64 = 'a75feaa4b700e5ad03f5439da4459c8f53503010c91390b1c2b9d6928e97e021'
$checksumType64 = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -UnzipLocation "$toolsDir" `
                             -Url64bit "$url64" `
                             -Checksum64 "$checksum64" `
                             -ChecksumType64 "$checksumType64"

# create empty sidecar so shimgen.exe creates shim for GUI rather than console
$guiExe = Get-ChildItem -Recurse -Path $toolsDir -Include "bitcoin-qt.exe"
if ($guiExe) {Set-Content -Path $($guiExe.FullName+".gui") -Value $null}

$packageName = $env:ChocolateyPackageName
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://bitcoincore.org/bin/bitcoin-core-32.1/bitcoin-32.1-win64.zip'
$checksum64 = 'b5b0c2cd007d69e96880907c79f9ae19ae82728f95fc8c923b4a07dab795b45d'
$checksumType64 = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -UnzipLocation "$toolsDir" `
                             -Url64bit "$url64" `
                             -Checksum64 "$checksum64" `
                             -ChecksumType64 "$checksumType64"

# create empty sidecar so shimgen.exe creates shim for GUI rather than console
$guiExe = Get-ChildItem -Recurse -Path $toolsDir -Include "bitcoin-qt.exe"
if ($guiExe) {Set-Content -Path $($guiExe.FullName+".gui") -Value $null}

$packageName = 'cports'
$url = 'https://www.nirsoft.net/utils/cports.zip'
$checksum = 'cbc8cdc5c89dd951ad1d62b8a4c3d26b0797147b49f61d521301c3ec16750cb4'
$checksumType = 'sha256'
$url64 = 'https://www.nirsoft.net/utils/cports-x64.zip'
$checksum64 = 'c2dc79b418a45b2b344e8301619447978c1a7f6526d1e1a35671344c4c5a906d'
$checksumType64 = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile = Join-Path $toolsDir "$($packageName).exe"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Url64bit "$url64" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType" `
                             -Checksum64 "$checksum64" `
                             -ChecksumType64 "$checksumType64"

Set-Content -Path ("$installFile.gui") `
            -Value $null

$packageName = 'cports'
$url = 'https://www.nirsoft.net/utils/cports.zip'
$checksum = 'b985b9a07a54e32dff83448ef8ea911c60a49269a3a82147d749f57e1271a75a'
$checksumType = 'sha256'
$url64 = 'https://www.nirsoft.net/utils/cports-x64.zip'
$checksum64 = '09f7c48ba9fc208c5a4d901361ec167a785cd527d64f2d4c1a08635b36b039ae'
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

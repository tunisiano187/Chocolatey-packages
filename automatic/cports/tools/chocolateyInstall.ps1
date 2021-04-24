$packageName = 'cports'
$url = 'https://www.nirsoft.net/utils/cports.zip'
$checksum = 'a384aa13d86ba2e38e8c73d6669f92da07892a895cad8e1bb6aec250269b5d3c'
$checksumType = 'sha256'
$url64 = 'https://www.nirsoft.net/utils/cports-x64.zip'
$checksum64 = '6288c8beaf775443201791d282b3c48508de37636376577c4319b19c525548db'
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

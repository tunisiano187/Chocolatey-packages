$packageName = 'cports'
$url = 'https://www.nirsoft.net/utils/cports.zip'
$checksum = '76d4b50656f53fd205d68e2bb8a2a2a48afa22d4b6e8af44a8cc9ee611253c0f'
$checksumType = 'sha256'
$url64 = 'https://www.nirsoft.net/utils/cports-x64.zip'
$checksum64 = 'd2a2d6ea1e7d692efe3dd3f53e581228894b6b1150955454a6c9d68a95ba3b4a'
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

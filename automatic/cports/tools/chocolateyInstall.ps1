$packageName = 'cports'
$url = 'https://www.nirsoft.net/utils/cports.zip'
$checksum = 'ff468efbbe2a99e114031ec742234989a49bd38a6e41d4d0d357daaddfc59183'
$checksumType = 'sha256'
$url64 = 'https://www.nirsoft.net/utils/cports-x64.zip'
$checksum64 = 'abd5a915e00a539bbf5edd8079441af83d95f34ef6e98c598c18423629c823b4'
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

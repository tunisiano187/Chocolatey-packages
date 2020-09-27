$packageName = 'cports'
$url = 'http://www.nirsoft.net/utils/cports.zip'
$checksum = '82bbbfe435ec377257ee1447af3d6af4e37f20fe23dfa719bdf22a3e990230ee'
$checksumType = 'sha256'
$url64 = 'http://www.nirsoft.net/utils/cports-x64.zip'
$checksum64 = '841066ed5d87271ae6832758cc3603718780c210e3055cc2a48146ddc545a53f'
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
$packageName = 'cports'
$url = 'https://www.nirsoft.net/utils/cports.zip'
$checksum = '60ba408766aab7719350f2b856b41bcd9f5e474fc40766382740399f0fdbfe8d'
$checksumType = 'sha256'
$url64 = 'https://www.nirsoft.net/utils/cports-x64.zip'
$checksum64 = '5960b25cb7e8b27ed80c03498a8d5795acfffee0fd8306b3d0d2ab7d37a6cb12'
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

$packageName = 'domainhostingview'
$url = 'http://www.nirsoft.net/utils/domainhostingview.zip'
$checksum = '19840123792425409b10d6259cb6c22cbbb3a6e1e1cc8b909926a71268a77fe9'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile = Join-Path $toolsDir "$($packageName).exe"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"

Set-Content -Path ("$installFile.gui") `
            -Value $null
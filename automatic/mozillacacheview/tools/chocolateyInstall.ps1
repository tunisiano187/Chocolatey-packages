$packageName = 'mozillacacheview'
$url = 'http://www.nirsoft.net/utils/mozillacacheview.zip'
$checksum = '0af82e8000371171b6e40a07e9c3424256650baae617ad108d248ddcf2dc01de'
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
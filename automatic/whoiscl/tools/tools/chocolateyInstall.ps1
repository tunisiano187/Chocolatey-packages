$packageName = 'whoiscl'
$url = 'http://www.nirsoft.net/utils/whoiscl.zip'
$checksum = 'cb042f522ca674288655739db24b389defac0d2f05bd5d7e915aefd3068e4d85'
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
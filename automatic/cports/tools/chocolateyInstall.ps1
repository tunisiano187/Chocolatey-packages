$packageName = 'cports'
$url = 'https://www.nirsoft.net/utils/cports.zip'
$checksum = '3158a7ffa589275f10c1e7568134cd3cb6db3723e181f6e8ab69667ccaca176b'
$checksumType = 'sha256'
$url64 = 'https://www.nirsoft.net/utils/cports-x64.zip'
$checksum64 = 'beb7dd4d190cbfa5b9a42a67650db42540f0de4cb79174f139f7c5c2607baf40'
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

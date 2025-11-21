$packageName = 'mweather.portable'
$url = 'https://www.nirsoft.net/utils/mweather.zip'
$checksum = 'e4d2fe1b3ec9b5661ca6e5053e77e8ef9364ecba57aa7d9f39ee3e4325b799f2'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile = Join-Path $toolsDir "mweather.exe"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"

Set-Content -Path ("$installFile.gui") `
            -Value $null

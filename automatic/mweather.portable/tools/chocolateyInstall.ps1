$packageName = 'mweather.portable'
$url = 'https://www.nirsoft.net/utils/mweather.zip'
$checksum = '00dfe305eb9e7a0b363e084891030f2639a9a857203028829f2943f4863db657'
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

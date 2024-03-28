$packageName = 'mweather.portable'
$url = 'https://www.nirsoft.net/utils/mweather.zip'
$checksum = 'd6db1ef17909bee1c5694051311ae7a62dc729aa3dcec39d76d3cf2d4cb4fb3e'
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

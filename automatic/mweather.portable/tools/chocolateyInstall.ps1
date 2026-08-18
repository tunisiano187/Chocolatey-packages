$packageName = 'mweather.portable'
$url = 'https://www.nirsoft.net/utils/mweather.zip'
$checksum = 'bdbd47b211647f9a308bb073012b9b129efff6de5a6d95893041635e5d867f56'
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

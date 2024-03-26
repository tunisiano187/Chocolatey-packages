$packageName = 'mweather.portable'
$url = 'http://www.nirsoft.net/utils/mweather.zip'
$checksum = '4afd59c78e272e25437d69efad4722806206d924c16c360c53d8e3eeaacea935'
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
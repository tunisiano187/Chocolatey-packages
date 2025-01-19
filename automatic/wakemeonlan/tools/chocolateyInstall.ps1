$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://www.nirsoft.net/utils/wakemeonlan.zip'
$checksum = '02d8e33e86038494659abd238004d5f7e1522c52dd49a1d35c8a7ab60362c463'
$checksumType = 'sha256'
#$url64 = $env:ChocolateyPackageName
#$checksum64 = $env:ChocolateyPackageName
#$checksumType64 = $env:ChocolateyPackageName
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile = Join-Path $toolsDir "$($packageName).exe"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"

Set-Content -Path ("$installFile.gui") `
            -Value $null

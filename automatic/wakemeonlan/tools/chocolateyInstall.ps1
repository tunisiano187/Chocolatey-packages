$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://www.nirsoft.net/utils/wakemeonlan.zip'
$checksum = 'cc5808bf0d345fcf7e39bb8df86aec29d87ec0064c91826bb81fc228a04b5aaa'
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

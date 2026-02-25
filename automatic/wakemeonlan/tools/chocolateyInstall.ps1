$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://www.nirsoft.net/utils/wakemeonlan.zip'
$checksum = '22b0b62c744ab3951581551bd064f5f76fced86f38f6dd40c95eda9281645848'
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

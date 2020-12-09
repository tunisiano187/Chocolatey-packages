$packageName = $env:ChocolateyPackageName
$url = 'http://www.nirsoft.net/utils/lastactivityview.zip'
$checksum = '8572b903d316b55e89fa7c129a7c8d0e1da597158fcde8a7210b2b1a6e34df17'
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
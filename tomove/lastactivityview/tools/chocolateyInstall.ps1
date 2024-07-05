$packageName = $env:ChocolateyPackageName
$url = 'https://www.nirsoft.net/utils/lastactivityview.zip'
$checksum = '09976fd76ae40a608f424655cda82b2be77c426c88ea95af78378b47630397bf'
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

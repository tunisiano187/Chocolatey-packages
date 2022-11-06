$packageName = $env:ChocolateyPackageName
$url = 'https://www.nirsoft.net/utils/lastactivityview.zip'
$checksum = 'ace91b961d16a4d59ef2e2545fc5c2159bec6daccc5eaff1ff689f51f9df4e82'
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

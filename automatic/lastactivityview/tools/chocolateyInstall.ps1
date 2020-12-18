$packageName = $env:ChocolateyPackageName
$url = 'https://www.nirsoft.net/utils/lastactivityview.zip'
$checksum = 'a668cfc978f76e081abd941d4ac1445cef3ad0c3e809f492bf096a5b40bcb831'
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

$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "https://www.chrysocome.net/downloads/dd-0.6beta3.zip"
$checksum       = 'C7A6A4CC4A107030B072FB479173D66E6D1D1098CF740C6DA4E9378C16B81C17'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName $packageName `
                -url $url `
                -checksum $checksum `
                -checksumType $checksumType `
                -unzipLocation "$toolsDir" `
                -specificFolder ""
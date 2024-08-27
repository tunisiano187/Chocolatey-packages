$packageName    = 'Cassandra'
$url            = 'https://dlcdn.apache.org/cassandra/5.0-rc2/apache-cassandra-5.0-rc2-bin.tar.gz'
$checksum       = 'd91e5a78870f78a0d23ba41ede599da8cdd78e47570a16dc71fdbbf28effcb05'
$checksumType   = 'sha256'
$installDir     = (Get-ToolsLocation +"/$packageName")
$unzipFolder    = Join-Path $env:TEMP "chocolatey\$packageName"

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    url             = $url
    checksum        = $checksum
    checksumType    = $checksumType
    unzipLocation   = $unzipFolder
}

Install-ChocolateyZipPackage @packageArgs
Get-ChocolateyUnzip -fileFullPath $unzipFolder -destination "$installDir"

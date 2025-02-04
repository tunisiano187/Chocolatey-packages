$packageName    = 'Cassandra'
$url            = 'https://dlcdn.apache.org/cassandra/5.0.3/apache-cassandra-5.0.3-bin.tar.gz'
$checksum       = 'fe1652e418c410b4eb77ae61def6934175759334171f9fdff0e455f77971515d'
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

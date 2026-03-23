$packageName    = 'Cassandra'
$url            = 'https://dlcdn.apache.org/cassandra/5.0.7/apache-cassandra-5.0.7-bin.tar.gz'
$checksum       = '556be693f1941aeb8ec1538fe6224cbefdca7bc3729f87ff0e24a0052eb98c33'
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

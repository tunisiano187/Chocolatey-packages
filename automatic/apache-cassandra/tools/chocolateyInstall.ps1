$packageName    = 'Cassandra'
$url            = 'https://dlcdn.apache.org/cassandra/5.0.2/apache-cassandra-5.0.2-bin.tar.gz'
$checksum       = 'd721834207838b9d01919dfc33625ad17b50fea03bf9f76cdd8d3ae3a8fd2947'
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

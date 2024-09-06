$packageName    = 'Cassandra'
$url            = 'https://dlcdn.apache.org/cassandra/5.0.0/apache-cassandra-5.0.0-bin.tar.gz'
$checksum       = 'bda1e57004cc964ec403f9b8c941cda9d4bb1225f786f2b1cd7dde3c71033465'
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

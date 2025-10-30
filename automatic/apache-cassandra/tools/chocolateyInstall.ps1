$packageName    = 'Cassandra'
$url            = 'https://dlcdn.apache.org/cassandra/5.0.6/apache-cassandra-5.0.6-bin.tar.gz'
$checksum       = '50033c31dc620c17fb0d8931c7a950ffe66e457cbf6eff1b7f94cba929344d4c'
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

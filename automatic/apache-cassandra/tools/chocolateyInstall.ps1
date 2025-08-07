$packageName    = 'Cassandra'
$url            = 'https://dlcdn.apache.org/cassandra/5.0.5/apache-cassandra-5.0.5-bin.tar.gz'
$checksum       = '17097f52fe9627a45867efefd8eee42d5fa4c4cbab6e2a92474aa1d370ea0aca'
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

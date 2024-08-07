$packageName    = 'Cassandra'
$url            = 'https://dlcdn.apache.org/cassandra/5.0-rc1/apache-cassandra-5.0-rc1-bin.tar.gz'
$checksum       = '5efb04e14cc455eea426677ce92bcf3e423591c9261c714fd6d8bae6951d959c'
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

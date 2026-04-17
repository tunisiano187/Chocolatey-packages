$packageName    = 'Cassandra'
$url            = 'https://dlcdn.apache.org/cassandra/5.0.8/apache-cassandra-5.0.8-bin.tar.gz'
$checksum       = '1579d7d3f2d812741a28cd2c2cbe29e83541bb4d25fb21ec2c00c1e4fb3b9a8f'
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

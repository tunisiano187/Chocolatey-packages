$packageName    = 'Cassandra'
$url            = 'http://apache.mirror.anlx.net/cassandra/3.7/apache-cassandra-3.7-bin.tar.gz'
$checksum       = ''
$checksumType   = ''
$installDir     = (Get-ToolsLocation +"/$packageName")

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    url             = $url
    checksum        = $checksum
    checksumType    = $checksumType
    unzipLocation   = (Join-Path $env:chocolateyPackageFolder tmp)
}

Install-ChocolateyZipPackage @packageArgs
Get-ChocolateyUnzip -fileFullPath (Join-Path $env:chocolateyPackageFolder tmp) -destination "$installDir"

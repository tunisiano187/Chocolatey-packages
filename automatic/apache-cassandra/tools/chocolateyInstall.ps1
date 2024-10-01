$packageName    = 'Cassandra'
$url            = 'https://archive.apache.org/dist/cassandra/5.0.1/apache-cassandra-5.0.1-bin.tar.gz'
$checksum       = '73f4c807b0aa4036500d5dc54e30ef82bcf549ab1917eff2bbc7189b0337ea84'
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

$packageName    = 'Cassandra'
$url            = 'https://dlcdn.apache.org/cassandra/5.0.9/apache-cassandra-5.0.9-bin.tar.gz'
$checksum       = 'eee1460b47ebe188a29521207230617f22aad7f9e1674f5ea454f10c8f344d61'
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

$packageName    = 'Cassandra'
$url            = 'https://dlcdn.apache.org/cassandra/4.1.5/apache-cassandra-4.1.5-bin.tar.gz'
$checksum       = 'ed184c361482e8b34f75537a1ac83755286313d6dcb0e11293813fb8ce4afbf5'
$checksumType   = 'sha256'
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

$packageName = 'Cassandra'
$authorVersion = '3.7'
$url = "http://apache.mirror.anlx.net/cassandra/3.7/apache-cassandra-3.7-bin.tar.gz"
$installDir = (Get-ToolsLocation +"/$packageName")

Install-ChocolateyZipPackage -packagename $packageName -url "$url" -unzipLocation (Join-Path $env:chocolateyPackageFolder tmp)
Get-ChocolateyUnzip -fileFullPath (Join-Path $env:chocolateyPackageFolder tmp) -destination "$installDir"

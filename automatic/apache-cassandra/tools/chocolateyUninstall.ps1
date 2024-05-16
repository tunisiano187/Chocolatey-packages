$packageName = 'Cassandra'
$installDir = (Get-ToolsLocation +"/$packageName")

rm -Recurse -Force $installDir

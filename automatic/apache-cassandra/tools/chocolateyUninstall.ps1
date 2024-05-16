$packageName = 'Cassandra'
$installDir = (Get-ToolsLocation +"/$packageName")

Remove-Item -Recurse -Force $installDir 
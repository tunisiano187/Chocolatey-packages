$packageName = 'aeroadmin.portable'
$url = 'http://www.aeroadmin.com/AeroAdmin_v3.0b.exe'
$fileFullPath = "$(split-path -parent $PSCommandPath)\AeroAdmin.exe"

Get-ChocolateyWebFile $packageName $fileFullPath $url
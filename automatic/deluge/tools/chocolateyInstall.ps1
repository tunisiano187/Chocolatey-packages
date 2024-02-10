$installerType = 'exe'
$silentArgs = '/S'
$url = 'http://download.deluge-torrent.org/windows/deluge-1.3.15-win32-py2.7.exe'
$checksum = 'd3f7d371b70ca10c7e912b9d3443fea3acd0c905aab4ac7799f02e65b58c8e59'
$checksumType = 'sha256'
$url64 = 'http://download.deluge-torrent.org/windows/deluge-1.3.15-win32-py2.7.exe'
$checksum64 = 'd3f7d371b70ca10c7e912b9d3443fea3acd0c905aab4ac7799f02e65b58c8e59'
$checksumType64 = 'sha256'
$validExitCodes = @(0)

$packageArgs = @{
	packageName		        = $env:ChocolateyPackageName
	fileType                = $installerType
	url				        = $url
	checksum		        = $checksum
	checksumType            = $checksumType
	url64bit   		        = $url64
	checksum64		        = $checksum64
	checksumType64          = $checksumType64
	silentArgs              = $silentArgs
    ValidExitCodes          = $validExitCodes
}

Install-ChocolateyPackage @packageArgs
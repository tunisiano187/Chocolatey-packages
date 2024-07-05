$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://ftp.osuosl.org/pub/deluge/windows/deluge-2.1.1-win32-setup.exe'
$checksum = '5f88c44f22937c43e765b08e9391b5978394a821f81eaca99baa6c2831d6224d'
$checksumType = 'sha256'
$url64 = 'https://ftp.osuosl.org/pub/deluge/windows/deluge-2.1.1-win64-setup.exe'
$checksum64 = '183f401f088cbb973633dbeeb16ded1326b7aa567acfc9de32855d5be14653ae'
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

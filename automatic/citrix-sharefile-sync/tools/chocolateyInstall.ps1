$ErrorActionPreference = 'Stop'
$installerType 			= 'exe'
$checksum 				= 'a8fcb8a7f50800c3c47bc90ade56437398610c6a9a8c54323716bfa9dc2ae33c'
$checksumType 			= 'sha256'
$checksum64 			= 'a8fcb8a7f50800c3c47bc90ade56437398610c6a9a8c54323716bfa9dc2ae33c'
$checksumType64 		= 'sha256'
$silentArgs 			= '/quiet /norestart'
$validExitCodes 		= @(0)

$url 					= 'https://dl.sharefile.com/sync2win'
$url64 					= $url

$packageArgs = @{
	packageName   		= $env:ChocolateyPackageName
	fileType      		= $installerType
	url           		= $url
	checksum      		= $checksum
	checksumType  		= $checksumType
	url64          		= $url64
	checksum64     		= $checksum64
	checksumType64 		= $checksumType64
	silentArgs    		= $silentArgs
	validExitCodes		= $validExitCodes
}

Install-ChocolateyPackage @packageArgs

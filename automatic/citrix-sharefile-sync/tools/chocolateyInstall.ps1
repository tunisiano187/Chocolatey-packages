$installerType 			= 'MSI'
$url 					= ''
$checksum 				= ''
$checksumType 			= ''
$url64 					= ''
$checksum64 			= ''
$checksumType64 		= ''
$silentArgs 			= '/quiet'
$validExitCodes 		= @(0)
$referer				= 'https://www.citrix.com/downloads/sharefile/clients-and-plug-ins/sharefile-sync-for-windows.html'

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

Invoke-WebRequest -Uri $referer -OutFile "$env:TEMP\sharefile.html"

Install-ChocolateyPackage @packageArgs
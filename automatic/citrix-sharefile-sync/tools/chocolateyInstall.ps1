$installerType 			= 'MSI'
$url 					= ''
$checksum 				= ''
$checksumType 			= ''
$url64 					= ''
$checksum64 			= ''
$checksumType64 		= ''
$silentArgs 			= '/quiet'
$validExitCodes 		= @(0)

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
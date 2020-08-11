$installerType 			= 'MSI'
$url 					= 'https://downloads.citrix.com/7110/ShareFileSync32_v3.24.106.0.msi?__gda__=1597158640_ae51ac8563bee34e581cbe984dfcc04f'
$checksum 				= 'dcf05efb9b81ae50fb6d0b0cd6b983866ab79d93544c48ed8c010fef0f0d09ed'
$checksumType 			= 'sha256'
$url64 					= 'https://downloads.citrix.com/7110/ShareFileSync64_v3.24.106.0.msi?__gda__=1597158640_fdfe77d68e813bc653ada1c074303277'
$checksum64 			= '4a4d085d22f6743b84f766d91395dd0b4e0ba2a2963257c1851e4ce7fbadec1c'
$checksumType64 		= 'sha256'
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

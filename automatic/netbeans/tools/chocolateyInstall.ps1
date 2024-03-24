$ErrorActionPreference = 'Stop'

$url			= ''
$checksum		= ''
$checksumType	= ''
$fileType		= 'exe'
$softwareName	= 'NetBeans*'
$silentArgs		= '--silent'

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    fileType      	= $fileType
    url           	= $url

    softwareName  	= $softwareName

    checksum      	= $checksum
    checksumType  	= $checksumType

    silentArgs   	= $silentArgs
	ValidExitCodes	= @(0)
}

Install-ChocolateyPackage @packageArgs

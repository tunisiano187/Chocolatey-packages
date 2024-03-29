$ErrorActionPreference = 'Stop'

$url			= 'https://dlcdn.apache.org/netbeans/netbeans-installers/21/Apache-NetBeans-21-bin-windows-x64.exe'
$checksum		= '9e43a717dacc083192f5e308576936103de63bf8907f39f633851b66c68ca1787d61d757772ef0ef50bb18347ee39017fe8222dd29a02b3636b490f88a13d078'
$checksumType	= 'sha512'
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

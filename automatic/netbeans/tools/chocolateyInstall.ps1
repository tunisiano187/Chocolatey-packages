$ErrorActionPreference = 'Stop'

$url			= 'https://github.com/Friends-of-Apache-NetBeans/netbeans-installers/releases/download/v28-build1/Apache-NetBeans-28.exe'
$checksum		= 'C85C7376C39B144332969A45037D4DD9424DC508C8F9B71E466DBC5ED9D136F6'
$checksumType	= 'sha256'
$fileType		= 'exe'
$softwareName	= 'NetBeans*'
$silentArgs		= '/S'

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

$ErrorActionPreference = 'Stop'

$url			= 'https://github.com/Friends-of-Apache-NetBeans/netbeans-installers/releases/download/v28-build2/Apache-NetBeans-28.exe'
$checksum		= '893B21E6FF4EB99C0171845E4C2AF15FAA6F3AE34687A4EC2E1CFFE14C5FB72F'
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

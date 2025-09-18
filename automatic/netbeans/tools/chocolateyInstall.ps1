$ErrorActionPreference = 'Stop'

$url			= 'https://github.com/Friends-of-Apache-NetBeans/netbeans-installers/releases/download/v27-build1/Apache-NetBeans-27.exe'
$checksum		= '6180E321D9897DA4B47690EAB67AFBB431F413F82F2443107910766DABC1A935'
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

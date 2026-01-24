$ErrorActionPreference = 'Stop'

$url			= 'https://github.com/Friends-of-Apache-NetBeans/netbeans-installers/releases/download/v29-rc1/Apache-NetBeans-29-rc1.exe'
$checksum		= '9E9DA43CA06F8B00ACE9A241D087AB13E46D714E6E1B0823D4A48011F2397B94'
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

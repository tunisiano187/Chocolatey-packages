$ErrorActionPreference = 'Stop'

$url			= 'https://dlcdn.apache.org/netbeans/netbeans-installers/25/Apache-NetBeans-25-bin-windows-x64.exe'
$checksum		= '4f05cbca95d9dd9b099c07da5a58d89767f164e2ffdb00bf1a814d1ed0acf1d52fee1af11a3c1d71a1e31bb55d09ab99c1fff550953e9a4939ef0943e72e6628'
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

$ErrorActionPreference = 'Stop'

$url			= 'https://github.com/Friends-of-Apache-NetBeans/netbeans-installers/releases/download/v29-build1/Apache-NetBeans-29.exe'
$checksum		= '152531686F53D9AF24D41172576C5FB780B9054E027ED38B496B1A7AEFA3BAA4'
$checksumType	= 'sha256'
$fileType		= 'exe'
$softwareName	= 'NetBeans*'
$silentArgs		= '--verbose --output "$env:TEMP\netbeans-install.log" --silent'

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

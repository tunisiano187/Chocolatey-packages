$ErrorActionPreference = 'Stop'

$url			= 'https://dlcdn.apache.org/netbeans/netbeans-installers/23/Apache-NetBeans-23-bin-windows-x64.exe'
$checksum		= 'e0521319856bc17837649d9cd85c5da6808960bba80e2f92331eea8338682ec6293322236156790e298178015a21e75d1d5e42b007856e70a05d635baab99697'
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

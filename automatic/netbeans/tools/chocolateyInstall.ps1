$ErrorActionPreference = 'Stop'

$url			= 'https://dlcdn.apache.org/netbeans/netbeans-installers/22/Apache-NetBeans-22-bin-windows-x64.exe'
$checksum		= 'cf7dbbce2a9c808ba262625b3d824e95cef1779f5ed65bfa6888a3d09a7fdadb5ecd187e88d2ed03ed62dc84eb8f30c328420b72951ea03b013c46455734ec33'
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

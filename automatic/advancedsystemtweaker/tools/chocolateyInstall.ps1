$ErrorActionPreference = "Stop"

$url 			= 'http://www.tweaking.com/files/setups/tweaking.com_advanced_system_tweaker_setup.exe'
$checksum 		= ''
$checksumType 	= ''

$packageArgs = @{
	packageName   = $env:ChocolateyPackageName
	fileType      = 'EXE'
	url           = $url
  
	softwareName  = 'amazon-chime*'
  
	checksum      = $checksum
	checksumType  = $checksumType
  
	silentArgs    = '/S'
	validExitCodes= @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
}

Install-ChocolateyPackage @packageArgs
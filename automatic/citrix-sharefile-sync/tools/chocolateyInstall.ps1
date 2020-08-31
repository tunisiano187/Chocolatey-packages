$ErrorActionPreference = 'Stop'
$installerType 			= 'MSI'
$url 					= 'https://downloads.citrix.com/7110/ShareFileSync32_v3.24.106.0.msi?__gda__=1598879382_c38c390a73da6daa17fbe6e449e1eb88'
$checksum 				= ''
$checksumType 			= ''
$url64 					= 'https://downloads.citrix.com/7110/ShareFileSync64_v3.24.106.0.msi?__gda__=1598879382_6111f17bb03d1116452b67051247ebd5'
$checksum64 			= ''
$checksumType64 		= ''
$silentArgs 			= '/quiet'
$validExitCodes 		= @(0)

$releases 				= 'https://www.citrix.com/downloads/sharefile/clients-and-plug-ins/sharefile-sync-for-windows.html'
$urls					=$(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_.rel -match '.msi'}).rel)
$url 					= "https:$($urls[0])"
$url64 					= "https:$($urls[1])"

$packageArgs = @{
	packageName   		= $env:ChocolateyPackageName
	fileType      		= $installerType
	url           		= $url
	checksum      		= $checksum
	checksumType  		= $checksumType
	url64          		= $url64
	checksum64     		= $checksum64
	checksumType64 		= $checksumType64
	silentArgs    		= $silentArgs
	validExitCodes		= $validExitCodes
}

$OSIsServerVersion = if ([Int]3 -eq [Int](Get-CimInstance -Class Win32_OperatingSystem).ProductType) {$True} else {$False}
if($OSIsServerVersion) {
  Write-Warning "Server system not supported"
  exit 0
} else {
  Install-ChocolateyPackage @packageArgs
}

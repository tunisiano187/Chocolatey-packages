$packageName = 'dexpot'
$installerType = 'EXE'
$url = 'http://dexpot.de/download/dexpot_1614_r2439.exe'
$checksum = ''
$checksumtype = 'sha256'
$silentArgs = '/S'
$validExitCodes = @(0)

try {
	Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes
} catch {
	throw	
}
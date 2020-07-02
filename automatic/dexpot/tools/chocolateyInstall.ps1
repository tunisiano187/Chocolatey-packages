$packageName = $env:ChocolateyPackageName
$installerType = 'EXE'
$url = 'http://dexpot.de/download/dexpot_1614_r2439.exe'
$checksum = ''
$checksumtype = 'sha256'
$silentArgs = '/S'
$validExitCodes = @(0)

try {
	Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
} catch {
	throw
}
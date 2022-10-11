$packageName = 'p4scc'
$installerType = 'EXE'
$url = 'http://www.perforce.com/downloads/perforce/r12.1/bin.ntx86/p4sccinst.exe'
$url64 = $url
$silentArgs = '/S'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes

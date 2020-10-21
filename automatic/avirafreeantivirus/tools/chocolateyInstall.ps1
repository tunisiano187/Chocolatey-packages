$packageName = 'avirafreeantivirus'
$installerType = 'EXE'
$url = 'http://personal.avira-update.com/package/webloader/win32/pecl/avira_free_antivirus.exe'
$silentArgs = ''
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes
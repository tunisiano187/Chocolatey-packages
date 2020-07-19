$packageName    = $env:ChocolateyPackageName
$installerType  = 'EXE'
$url32          = 'http://personal.avira-update.com/package/webloader/win32/pecl/avira_free_antivirus.exe'
$checksum32     = ''
$checksumType32 = ''
$silentArgs     = '/s'
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    url             = $url32
    checksum        = $checksum32
    checksumType    = $checksumType32
    silentArgs      = $silentArgs
    validExitCodes  = $validExitCodes
}

Install-ChocolateyPackage @packageArgs
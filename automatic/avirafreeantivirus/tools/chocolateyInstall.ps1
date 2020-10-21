$ErrorActionPreference = 'Stop';

$url            = 'http://personal.avira-update.com/package/webloader/win32/pecl/avira_free_antivirus.exe'
$checksum       = ''
$checksumType   = ''
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileType      = 'EXE'
    url           = $url

    softwareName  = "$($env:ChocolateyPackageName)*"

    checksum      = $checksum
    checksumType  = $checksumType

    silentArgs    = "/s"
    validExitCodes= @(0, 3010, 1641)
  }
  
  Install-ChocolateyPackage @packageArgs
  
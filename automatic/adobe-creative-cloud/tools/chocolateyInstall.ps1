$url            = 'https://ccmdls.adobe.com/AdobeProducts/KCCC/1/win32/CreativeCloudSet-Up.exe' # download url
$checksum       = ''
$checksumType   = ''

$silentArgs     = '/quiet' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileType      = 'EXE'
    url           = $url

    softwareName  = 'Adobe Creative Cloud Client*'

    checksum      = $checksum
    checksumType  = $checksumType

    silentArgs    = $silentArgs
    validExitCodes= $validExitCodes
  }

  Install-ChocolateyPackage @packageArgs
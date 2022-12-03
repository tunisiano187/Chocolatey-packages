$url          = 'http://sourceforge.net/projects/projectlibre/files/ProjectLibre/1.5.9/projectlibre-1.5.9.msi/download'
$checksum     = ''
$checksumType = ''

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileType      = 'EXE'
    url           = $url
    checksum      = $checksum
    checksumType  = $checksumType
  
    softwareName  = "$($env:ChocolateyPackageName)*"
  

    silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes= @(0)
  }
  
  Install-ChocolateyPackage @packageArgs
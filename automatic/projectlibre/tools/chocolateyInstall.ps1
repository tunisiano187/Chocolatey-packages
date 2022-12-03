$url32          = 'http://sourceforge.net/projects/projectlibre/files/ProjectLibre/1.5.9/projectlibre-1.5.9.msi/download'
$checksum32     = ''
$checksumType32 = ''

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileType      = 'EXE'
    url           = $url32
    checksum      = $checksum32
    checksumType  = $checksumType32
  
    softwareName  = "$($env:ChocolateyPackageName)*"
  

    silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes= @(0)
  }
  
  Install-ChocolateyPackage @packageArgs
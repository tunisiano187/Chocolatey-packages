$url          = 'https://netix.dl.sourceforge.net/project/projectlibre/ProjectLibre/1.9.3/projectlibre-1.9.3.exe'
$checksum     = '069f0d89a94a35d8105a59bdb1e4e4765aabca378d17c7b21c732fd61c5cbed3'
$checksumType = 'sha256'

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

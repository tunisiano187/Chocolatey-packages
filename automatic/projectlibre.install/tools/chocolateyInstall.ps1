$url          = 'https://downloads.sourceforge.net/project/projectlibre/ProjectLibre/1.9.8/ProjectLibre-1.9.8.msi'
$checksum     = ''
$checksumType = 'sha256'

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileType      = 'MSI'
    url           = $url
    checksum      = $checksum
    checksumType  = $checksumType
    silentArgs   = '/quiet /norestart'
    validExitCodes= @(0, 3010)
  }

  Install-ChocolateyPackage @packageArgs

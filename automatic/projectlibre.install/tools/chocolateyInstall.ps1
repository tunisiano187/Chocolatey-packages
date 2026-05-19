$url          = 'https://downloads.sourceforge.net/project/projectlibre/ProjectLibre/1.9.8/ProjectLibre-1.9.8.msi'
$checksum     = '32e46ba3ce7b3a81dc8ec648f6baf8f6f6056c8cf9203f75f8187e9e4637833f'
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

$url          = 'https://sourceforge.net/projects/projectlibre/files/ProjectLibre/1.9.8/ProjectLibre-1.9.8.msi/download'
$checksum     = '32E46BA3CE7B3A81DC8EC648F6BAF8F6F6056C8CF9203F75F8187E9E4637833F'
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

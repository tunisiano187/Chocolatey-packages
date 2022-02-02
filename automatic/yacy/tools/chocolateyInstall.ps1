$installerType  = 'exe'
$silentArgs     = '/S'
$url            = 'http://yacy.net/release/yacy_v1.90_20160704_9000.exe'
$checksum       = '33531b65a05d9472a9b38fdc25e1d331699e7114d60e058a0e4505458d275e70'
$checksumType   = 'sha256'

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileType      = $installerType
    url           = $url
    checksum      = $checksum
    checksumType  = $checksumType
    silentArgs    = $silentArgs
    validExitCodes= @(0)
  }

Install-ChocolateyPackage @packageArgs

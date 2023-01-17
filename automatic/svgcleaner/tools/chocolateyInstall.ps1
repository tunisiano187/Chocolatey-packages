$url            = 'http://sourceforge.net/projects/svgcleaner/files/v0.6.2/SVGCleanerSetup_0.6.2.exe'
$checksum       = '1373ff21e940a287c60ed24babc260e444388aeb'
$checksumType   = 'sha1'

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileType      = 'EXE'
    url           = $url

    softwareName  = 'thymiosuite*'

    checksum      = $checksum
    checksumType  = $checksumType

    validExitCodes= @(0, 3010, 1641)
    silentArgs   = '/S'
  }

Install-ChocolateyPackage @packageArgs

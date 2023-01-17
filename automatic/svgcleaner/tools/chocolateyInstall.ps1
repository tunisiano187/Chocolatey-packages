$url            = 'https://github.com/RazrFalcon/svgcleaner-gui/releases/download/v0.9.5/svgcleaner_win32_0.9.5.exe'
$checksum       = '375be8fc02fa7241626a75523fba79d80e3e466cad9ba0cd6a32f1c8f959600e'
$checksumType   = 'sha256'

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

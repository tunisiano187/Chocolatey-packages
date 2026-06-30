$ErrorActionPreference  = 'Stop'
$url                    = 'https://github.com/transmission/transmission/releases/download/4.1.3/transmission-4.1.3-x86.msi'
$checksum               = '74485b7b5d494cf98549e9165fd8f64a8640f2990aeee5edb43fae529dc0ec29'
$checksumType           = 'sha256'
$url64                  = 'https://github.com/transmission/transmission/releases/download/4.1.3/transmission-4.1.3-x64.msi'
$checksum64             = 'c8ea492d8f46fadac26e0c05b244cabba556201d5fe348dfcf1cf036621741f8'
$checksumType64         = 'sha256'

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    fileType        = 'msi'
    url             = $url
    checksum        = $checksum
    checksumType    = $checksumType
    Url64bit        = $url64
    Checksum64      = $checksum64
    ChecksumType64  = $checksumType64
    silentArgs      = "/quiet /qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
    validExitCodes  = @(0,1603,3010)
  }

Install-ChocolateyPackage @packageArgs

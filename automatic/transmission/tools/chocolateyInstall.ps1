$ErrorActionPreference  = 'Stop'
$url                    = 'https://github.com/transmission/transmission/releases/download/4.0.2/transmission-4.0.2-x86.msi'
$checksum               = '96d5730fdcac459b1849948d740c04ad6b9d898f920eeed8d9bbe88f7061090e'
$checksumType           = 'sha256'
$url64                  = 'https://github.com/transmission/transmission/releases/download/4.0.2/transmission-4.0.2-x64.msi'
$checksum64             = '1b8bbc17863e0ffc243f0cf5095b93cc2c8589ce09d4e9bece7d24812a8b7d09'
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

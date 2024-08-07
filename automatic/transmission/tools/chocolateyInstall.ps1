$ErrorActionPreference  = 'Stop'
$url                    = 'https://github.com/transmission/transmission/releases/download/4.0.6/transmission-4.0.6-x86.msi'
$checksum               = 'b7bdac970c686cfcdc249dc96fabb83fe85057e7d53f4c9aa55dc71891ba8c26'
$checksumType           = 'sha256'
$url64                  = 'https://github.com/transmission/transmission/releases/download/4.0.6/transmission-4.0.6-x64.msi'
$checksum64             = '29417282f2a5405018a211aa94e60d324657cf347e7a496ca7a51798ede0f6c1'
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

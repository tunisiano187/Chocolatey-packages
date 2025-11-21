$ErrorActionPreference  = 'Stop'
$url                    = 'https://github.com/transmission/transmission/releases/download/4.1.0-beta.3/transmission-4.1.0-beta.3+rf20fd5e373-x86.msi'
$checksum               = '5173d9e4720d6f9b8d79c7796c775c80a16e84cdf2444a2a06da9303661f6153'
$checksumType           = 'sha256'
$url64                  = 'https://github.com/transmission/transmission/releases/download/4.1.0-beta.3/transmission-4.1.0-beta.3+rf20fd5e373-x64.msi'
$checksum64             = '588fa221d0b95ba4e1c9bee36a5364298021782e6c0b7688cfd2d64b345357db'
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

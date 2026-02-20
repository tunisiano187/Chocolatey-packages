$ErrorActionPreference  = 'Stop'
$url                    = 'https://github.com/transmission/transmission/releases/download/4.1.1/transmission-4.1.1-x86.msi'
$checksum               = 'ac43a305da0cd41d91b87c0e698a7c691a403ac9f5553faff687cdd3622da7dc'
$checksumType           = 'sha256'
$url64                  = 'https://github.com/transmission/transmission/releases/download/4.1.1/transmission-4.1.1-x64.msi'
$checksum64             = 'f3d2c0164adb38086710ed6c3297ef9f9c8d7d674bab898f9d71c3ecfdd0d4e6'
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

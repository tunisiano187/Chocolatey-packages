$ErrorActionPreference  = 'Stop'
$url                    = 'https://github.com/transmission/transmission/releases/download/4.1.4/transmission-4.1.4-x86.msi'
$checksum               = '6721e8c8bc33e59e34bf6d2fd8abd608a2af826a4c96d4f02cf86542d582fbed'
$checksumType           = 'sha256'
$url64                  = 'https://github.com/transmission/transmission/releases/download/4.1.4/transmission-4.1.4-x64.msi'
$checksum64             = 'cf51e5772f39a3ead3c8f763b689399b9b4b8b016a4c0ca68ab5d6c634be2e1c'
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

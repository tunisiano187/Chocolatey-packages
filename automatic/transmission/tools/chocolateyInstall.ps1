$ErrorActionPreference  = 'Stop'
$url                    = 'https://github.com/transmission/transmission/releases/download/4.1.0/transmission-4.1.0-x86.msi'
$checksum               = 'cddd35de5ca686fd6c9b65a1ec22ee6b5744d033b389365ca62eddc6e7843b40'
$checksumType           = 'sha256'
$url64                  = 'https://github.com/transmission/transmission/releases/download/4.1.0/transmission-4.1.0-x64.msi'
$checksum64             = '9a0c14d2aab07fa2e7084a4e0d4a7a2bfaef41c7df794b273fbd8b2ad997c2f7'
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

$ErrorActionPreference  = 'Stop'
$url                    = 'https://github.com/transmission/transmission/releases/download/4.0.5/transmission-4.0.5-x86.msi'
$checksum               = '416f6d6fd96b7481c9cf75a89ba66d61a0d9c1237703bad799e5574404cf6b14'
$checksumType           = 'sha256'
$url64                  = 'https://github.com/transmission/transmission/releases/download/4.0.5/transmission-4.0.5-x64.msi'
$checksum64             = 'a698a6b39abf307c72f3a9152f320e290dc967927821161521f1460db74d7654'
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

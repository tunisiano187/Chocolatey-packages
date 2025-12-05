$ErrorActionPreference  = 'Stop'
$url                    = 'https://github.com/transmission/transmission/releases/download/4.1.0-beta.4/transmission-4.1.0-beta.4+rc92b42de9c-x86.msi'
$checksum               = '0e11707e8488126b7850ec4c0f4cd4cd041b3e8b8919154325cf12079eeac4cd'
$checksumType           = 'sha256'
$url64                  = 'https://github.com/transmission/transmission/releases/download/4.1.0-beta.4/transmission-4.1.0-beta.4+rc92b42de9c-x64.msi'
$checksum64             = 'b52105733c355957ba2b0a865b5decf60ae19f5e3a900bc66e0a63c65de95601'
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

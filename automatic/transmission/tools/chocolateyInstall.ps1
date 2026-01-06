$ErrorActionPreference  = 'Stop'
$url                    = 'https://github.com/transmission/transmission/releases/download/4.1.0-beta.5/transmission-4.1.0-beta.5+r11d3fc6f5a-x86.msi'
$checksum               = '5484dd673c1db1bd95a4a51ea5d4dc1c135d9867178107eae722286fad0be995'
$checksumType           = 'sha256'
$url64                  = 'https://github.com/transmission/transmission/releases/download/4.1.0-beta.5/transmission-4.1.0-beta.5+r11d3fc6f5a-x64.msi'
$checksum64             = '65be8bc603a54e4352768508ffa62b794a9415b56869daad565599cab4897bf3'
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

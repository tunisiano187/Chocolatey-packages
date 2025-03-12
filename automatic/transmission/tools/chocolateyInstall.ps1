$ErrorActionPreference  = 'Stop'
$url                    = 'https://github.com/transmission/transmission/releases/download/4.1.0-beta.2/transmission-4.1.0-beta.2+rac5c9e082d-x86.msi'
$checksum               = 'db851082f933acc1643346aad52c93b31d15ee11eee38452528cdc2fd2504315'
$checksumType           = 'sha256'
$url64                  = 'https://github.com/transmission/transmission/releases/download/4.1.0-beta.2/transmission-4.1.0-beta.2+rac5c9e082d-x64.msi'
$checksum64             = '910dd0796186fcc98f42f13757458aa994f3d307333c50ea84d76051cb7e6755'
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

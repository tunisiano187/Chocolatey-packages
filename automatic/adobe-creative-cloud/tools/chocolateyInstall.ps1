﻿$url            = 'https://prod-rel-ffc-ccm.oobesaas.adobe.com/adobe-ffc-external/core/v1/wam/download?sapCode=KCCC&productName=Creative%20Cloud&os=win&environment=prod' # download url
$checksum       = '97cd4cd7793cb35483275cb108cf05109cb98c26d025b95c1e89c78f0983b736'
$checksumType   = 'sha256'

$silentArgs     = '/quiet' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileType      = 'EXE'
    url           = $url

    softwareName  = 'Adobe Creative Cloud Client*'

    checksum      = $checksum
    checksumType  = $checksumType

    silentArgs    = $silentArgs
    validExitCodes= $validExitCodes
  }

  Install-ChocolateyPackage @packageArgs

$ErrorActionPreference     = 'Stop'
$url                       = 'https://www.sdcard.org/downloads/formatter/eula_windows/SDCardFormatterv5_WinEN.zip'
$Checksum                  = '89F77FC36F451FA16AD911145EA554F5651D9BC023EC1726FA66DBF54E1AE920'
$ChecksumType              = 'sha256'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$UnzipArgs = @{
    PackageName     = $env:chocolateyPackageName
    Url             = $url
    Checksum        = $Checksum
    checksumType    = $ChecksumType
    UnzipLocation   = $toolsDir
}

Install-ChocolateyZipPackage @UnzipArgs

$fileLocation = (get-childitem -Path $toolsDir -Filter "*.exe" -Recurse).FullName

$packageArgs = @{
    packageName     = $env:chocolateyPackageName
    file            = $fileLocation
    fileType        = 'EXE'
    validExitCodes  = @(0, 3010, 1641)
    silentArgs      = '/s /v"/qn /norestart"'
}

Install-ChocolateyInstallPackage @packageArgs

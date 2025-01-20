$ErrorActionPreference     = 'Stop'
$url                       = 'https://www.sdcard.org/downloads/formatter/eula_windows/SDCardFormatterv5_WinEN.zip'
$Checksum                  = '89F77FC36F451FA16AD911145EA554F5651D9BC023EC1726FA66DBF54E1AE920'
$ChecksumType              = 'sha256'

$curDir	= "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$toolsDir = Join-Path $curDir "tools"

$UnzipArgs = @{
    PackageName     = $env:chocolateyPackageName
    Url32           = $url
    Checksum32      = $Checksum
    checksumType    = $ChecksumType
    UnzipLocation   = $toolsDir
}

Install-ChocolateyZipPackage @UnzipArgs

$packageArgs = @{
    packageName     = $env:chocolateyPackageName
    file            = (get-childitem -Filter "*.exe" -Recurse).FullName
    fileType        = 'EXE'
    validExitCodes  = @(0, 3010, 1641)
    silentArgs      = '/s /v"/qn /norestart"'
}

Install-ChocolateyInstallPackage @packageArgs

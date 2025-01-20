$ErrorActionPreference     = 'Stop'
$url                       = 'https://www.sdcard.org/downloads/formatter/eula_windows/SDCardFormatterv5_WinEN.zip'
$Checksum                  = ''
$ChecksumType              = ''

$curDir	= "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$toolsDir = Join-Path $curDir "tools"

$UnzipArgs = @{
    PackageName     = $env:chocolateyPackageName
    Url32           = $url
    Checksum32      = $Checksum
    checksumType    = $ChecksumType
    UnzipLocation   = $toolsDir
}

Get-ChocolateyUnzip @UnzipArgs

$packageArgs = @{
    packageName     = $env:chocolateyPackageName
    FileFullPath    = (get-childitem -Filter "*.exe" -Recurse).FullName
    fileType        = 'EXE'
    validExitCodes  = @(0, 3010, 1641)
    silentArgs      = '/s /v"/qn /norestart"'
}

Install-ChocolateyInstallPackage @packageArgs

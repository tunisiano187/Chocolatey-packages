$ErrorActionPreference     = 'Stop'
$url                       = 'https://www.sdcard.org/downloads/formatter/eula_windows/SD%20Card%20Formatter%20Setup.exe'
$Checksum                  = '0243f9adae333f8a158d8137c29a64f411a0c3dc7827715d49483235852db091'
$ChecksumType              = 'sha256'

$UnzipArgs = @{
    PackageName     = $env:chocolateyPackageName
    Url32           = $url
    Checksum32      = $Checksum
    checksumType    = $ChecksumType
    UnzipLocation   = $ToolsPath
}

Get-ChocolateyUnzip @UnzipArgs

$packageArgs = @{
    packageName     = $env:chocolateyPackageName
    file            = (get-childitem -Filter "*.exe" -Recurse).FullName
    fileType        = 'EXE'
    validExitCodes  = @(0, 3010, 1641)
    silentArgs      = '/s /v"/qn /norestart"'
}

Install-ChocolateyInstallPackage @packageArgs

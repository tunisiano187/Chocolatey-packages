$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$os=(Get-WMIObject win32_operatingsystem).Version.split('.')
if(([int]$os[0] -le [int]6) -and ([int]$os[1] -le [int]3)) {
    Write-output "Operating system not supported"
    exit 0;
}

$SpecificFolder = 'SDIO_1.12.12.753'

$packageArgs = @{
    packageName     = 'sdio'
    unzipLocation   = $toolsDir
    fileType        = 'ZIP'
    SpecificFolder  = $SpecificFolder
    url             = 'https://www.glenn.delahoy.com/downloads/sdio/SDIO_1.12.12.753.zip'
    checksum        = 'c24c4d805947b473c5f9abf3fa3b2168b1aaf8b282d612d004fd60774da49193'
    checksumType    = 'sha256'
}

Remove-Item "$ToolsDir\SDIO_*" -Force -Recurse # Cleanup old versions
Install-ChocolateyZipPackage @packageArgs

if (!(Test-Path -path "$ENV:ALLUSERSPROFILE\SDIO")) {
    New-Item "$ENV:ALLUSERSPROFILE\SDIO" -ItemType Directory
}

$shortcutName    = 'Snappy Driver Installer Origin'
$fileName32      = 'SDIO_R753.exe'
$fileName64      = 'SDIO_x64_R753.exe'
$fullVersion     = '1.12.12.753'
$FileFullpath32  = Join-Path $ToolsDir\SDIO_$fullVersion $fileName32
$FileFullpath64  = Join-Path $ToolsDir\SDIO_$fullVersion $fileName64

if (Get-OSArchitectureWidth -eq 64) {
    Install-ChocolateyShortcut -targetPath $FileFullpath64 -WorkingDirectory "%ALLUSERSPROFILE%\SDIO" -shortcutFilePath "$env:Public\Desktop\$shortcutName.lnk"
    Install-ChocolateyShortcut -targetPath $FileFullpath64 -WorkingDirectory "%ALLUSERSPROFILE%\SDIO" -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk"
} else {
    Install-ChocolateyShortcut -targetPath $FileFullpath32 -WorkingDirectory "%ALLUSERSPROFILE%\SDIO" -shortcutFilePath "$env:Public\Desktop\$shortcutName.lnk"
    Install-ChocolateyShortcut -targetPath $FileFullpath32 -WorkingDirectory "%ALLUSERSPROFILE%\SDIO" -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk"
}

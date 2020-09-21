$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName   = 'sdio'
    unzipLocation = $toolsDir
    fileType      = 'ZIP'
    url           = 'https://downloads.sourceforge.net/project/snappy-driver-installer-origin/SDIO_1.6.3.712.zip'
    checksum      = 'c512ea9f56e3301b8f57cc19a030f59cb0a8775a353947d09b5c900f28cefa80'
    checksumType  = 'sha256'
}

Remove-Item "$ToolsDir\SDIO_*" -Force -Recurse # Cleanup old versions
Install-ChocolateyZipPackage @packageArgs

if (!(Test-Path -path "$ENV:ALLUSERSPROFILE\SDIO")) {
    New-Item "$ENV:ALLUSERSPROFILE\SDIO" -ItemType Directory
}

$shortcutName    = 'Snappy Driver Installer Origin'
$baseVersion     = '712'
$fileName32      = 'SDIO_R712.exe'
$fileName64      = 'SDIO_x64_R712.exe'
$fullVersion     = '1.5.8.707'
$FileFullpath32  = Join-Path $ToolsDir\SDIO_$fullVersion $fileName32
$FileFullpath64  = Join-Path $ToolsDir\SDIO_$fullVersion $fileName64

if (Get-OSArchitectureWidth -eq 64) {
    Install-ChocolateyShortcut -targetPath $FileFullpath64 -WorkingDirectory "%ALLUSERSPROFILE%\SDIO" -shortcutFilePath "$env:Public\Desktop\$shortcutName.lnk"
    Install-ChocolateyShortcut -targetPath $FileFullpath64 -WorkingDirectory "%ALLUSERSPROFILE%\SDIO" -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk"
} else {
    Install-ChocolateyShortcut -targetPath $FileFullpath32 -WorkingDirectory "%ALLUSERSPROFILE%\SDIO" -shortcutFilePath "$env:Public\Desktop\$shortcutName.lnk"
    Install-ChocolateyShortcut -targetPath $FileFullpath32 -WorkingDirectory "%ALLUSERSPROFILE%\SDIO" -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk"
}

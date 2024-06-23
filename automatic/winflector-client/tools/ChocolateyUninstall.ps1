$ErrorActionPreference = 'Stop';
$packageName    = 'winflector-client'
$softwareName   = 'Windows Driver Package - Era software*'
$installerType  = 'EXE' 
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
$validExitCodes = @(0, 3010, 1605, 1614, 1641)
$file           = "$env:appdata\Winflector\uninst\unins000.exe"
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "WFCuninstall.ahk"

Start-Process $ahkExe $ahkFile

 Uninstall-ChocolateyPackage -PackageName $packageName `
                                -FileType $installerType `
                                -SilentArgs "$silentArgs" `
                                -ValidExitCodes $validExitCodes `
                                -File "$file"
 

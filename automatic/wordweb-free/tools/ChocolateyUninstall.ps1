$ErrorActionPreference = 'Stop'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$osBitness      = Get-ProcessorBits
$packageName    = 'wordweb-free'
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\wordweb-free-uninstall.ahk"

Start-Process $ahkExe $ahkFile

if ($osBitness -eq '64'){
    & "${ENV:ProgramFiles(x86)}\WordWeb\uninst.exe"
   } else {
     & "$ENV:ProgramFiles\WordWeb\uninst.exe"
    }

While (Get-Process "autohotkey" -EA SilentlyContinue) {Start-Sleep -Seconds 1}

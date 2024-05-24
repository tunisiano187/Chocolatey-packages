$packageName = 'apacheds'

if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\Install-ChocolateyService030.ps1"
. "$PSScriptRoot\Uninstall-ChocolateyZipPackage030.ps1"

Uninstall-ChocolateyService030 "$packageName"

Uninstall-ChocolateyZipPackage030 "$packageName"
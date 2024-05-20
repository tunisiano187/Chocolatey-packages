# https://shark007.net/files/ADVANCED_64bitCodecs.7z
$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortcutName = 'Shark007''s 64bit ADVANCED Codecs.lnk'

if (Test-Path "$env:ProgramFiles\Shark007\ADVANCED_64bitCodecs"){ Remove-Item "$env:ProgramFiles\Shark007\ADVANCED_64bitCodecs" -Recurse -Force -ErrorAction SilentlyContinue }
if (Test-Path "$env:ProgramFiles\Shark007\Shark007Codecs\Tools\AutoUpdate.exe"){
	Write-Host "  ** Running AutoUpdate." -Foreground Magenta
	Start-ChocolateyProcessAsAdmin -Statements "silent" -ExeToRun "$env:ProgramFiles\Shark007\Shark007Codecs\Tools\AutoUpdate.exe" -WorkingDirectory "$env:ProgramFiles\Shark007\Shark007Codecs\Tools"
#TODO: Check for exit code 1 and if so, run again
	return
}

$packageArgs = @{
  packageName    = $env:chocolateyPackageName
  Destination    = "$env:ProgramFiles\Shark007"
  FileFullPath64 = "$toolsDir\Shark007Codecs.7z"
}
Get-ChocolateyUnzip @packageArgs

Start-ChocolateyProcessAsAdmin -Statements "silent" -ExeToRun "$env:ProgramFiles\Shark007\Shark007Codecs\Launcher64.exe" -WorkingDirectory "$env:ProgramFiles\Shark007\Shark007Codecs"
Start-ChocolateyProcessAsAdmin -Statements "users" -ExeToRun "$env:ProgramFiles\Shark007\Shark007Codecs\Tools\Settings64_portable.exe" -WorkingDirectory "$env:ProgramFiles\Shark007\Shark007Codecs\Tools\"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$env:ProgramFiles\Shark007\Shark007Codecs\Launcher64.exe" -RunAsAdmin
Remove-Item "$toolsDir\Shark007Codecs.7z" | Out-Null

# UPDATE INSTRUCTIONS:
# replace the .7z file

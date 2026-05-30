$ErrorActionPreference = 'Stop'
$url            = 'https://www.wagnardsoft.com/DDU/download/DDU%20v18.1.5.4.exe'
$checksum       = 'fa6656c25241f1ce94460d3eedf2982ccf272f8c82589fc257c60182b2e5168a'
$checksumType   = 'sha256'
$referer        = 'https://www.wagnardsoft.com/display-driver-uninstaller-ddu'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Invoke-WebRequest -Uri $referer -OutFile "$env:TEMP/test.html" #  Required to be allowed just after

$packageArgs		        = @{
    UnzipLocation	          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
	packageName		          = $env:ChocolateyPackageName
	url				          = $url
	checksum		          = $checksum
	fileType                  = 'exe'
	checksumType              = $checksumType
	silentArgs                = '/s'
}

Remove-Item "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\*.exe"
Remove-Item "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\DDU*" -Recurse

Install-ChocolateyZipPackage @packageArgs

# Create shortcuts so users can easily find the app
$exePath = Get-ChildItem "$toolsDir\DDU*" -Filter "*.exe" -ErrorAction SilentlyContinue | Select-Object -First 1
if ($exePath) {
    Install-ChocolateyShortcut -ShortcutFilePath "$env:Public\Desktop\DDU.lnk" -TargetPath $exePath.FullName -Description "Display Driver Uninstaller"
    Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\DDU.lnk" -TargetPath $exePath.FullName -Description "Display Driver Uninstaller"
}

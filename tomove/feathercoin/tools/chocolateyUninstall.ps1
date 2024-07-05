$fileType 		= 'exe'
$silentArgs 	= '/S'
$validExitCodes = @(0)
$unPath 		= "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$unString 		= (Get-ItemProperty "$unPath\$packageName*" UninstallString).UninstallString

$packageArgs	= @{
	PackageName     = $env:ChocolateyPackageName
	FileType		= $fileType
	SilentArgs		= $silentArgs
	File			= $unString
	ValidExitCodes	= $validExitCodes
}

Uninstall-ChocolateyPackage @packageArgs
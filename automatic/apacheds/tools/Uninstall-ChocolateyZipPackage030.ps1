function Uninstall-ChocolateyZipPackage030 {
param(
  [string] $packageName
)
	if(!$packageName) {
		Write-ChocolateyFailure "Uninstall-ChocolateyZipPackage030" "Missing PackageName input parameter."
		return
	}
	
	ChildItem "$env:ChocolateyInstall\lib\${packageName}.*" -Recurse -Filter "${packageName}Install.zip.txt" | 
	ForEach-Object{ $installLocation = (Get-Content $_.FullName | Select-Object -First 1);
		if (("$installLocation" -match "${packageName}|adt-bundle-windows-x86_64") -and (Test-Path -Path "$installLocation")) {
			Write-Host "Uninstalling by removing directory $installLocation";
			Remove-Item -Recurse -Force "$installLocation"
		}
	}
}
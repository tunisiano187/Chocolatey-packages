$rootPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Install-ChocolateyZipPackage 'slpolicy' `
	'http://www.winsiderss.com/tools/slpolicy.zip' `
	$rootPath;
if ([intptr]::Size -eq 8) {
	$ignorePath  = "$($rootPath)\slpolicy\i386";
}
else {
	$ignorePath  = "$($rootPath)\slpolicy\x64";
}
mkdir $ignorePath
New-Item -Type File "$($ignorePath)\slpolicy.exe.ignore"
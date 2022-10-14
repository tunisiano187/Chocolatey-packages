$package = 'mightymoose'
$file = (Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{DE3A8FE7-5918-471A-BF59-84C2C3328CCF}_is1").UninstallString
Uninstall-ChocolateyPackage $package 'EXE' -file $file
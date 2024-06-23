$packageName = 'softsqueeze'
Uninstall-ChocolateyZipPackage
remove-item "$env:Public\Desktop\Softsqueeze.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Softsqueeze.lnk" -Force -ErrorAction 'SilentlyContinue'

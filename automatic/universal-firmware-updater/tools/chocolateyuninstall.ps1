$packageName = 'universal-firmware-updater'

remove-item "$env:Public\Desktop\WD Firmware Updater.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\WD Firmware Updater.lnk" -Force -ErrorAction 'SilentlyContinue'


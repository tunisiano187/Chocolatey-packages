# Ubuntu-1604 doesn't support being silently installed. This script kludges it.
$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-ubuntu-1604'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://aka.ms/wsl-ubuntu-1604'
$checksum       = '24F2926D359B6ABAE595CDA7300AEDC567C294777D4BFC8AACC0E6598DB9680A'
$unzipLocation  = "$toolsDir\wslfiles"

# When Chocolatey moves the package files in the lib directory to lib-bkp upon upgrade it will cause a 
# disconnection between WSL and the registered location of the WSL distribution files. 
# It was considered to unregister the distribution and reinstall, but anything created, installed, or upgraded 
# in the current distribution's filesystem would be lost. Decided: Best to abort. 
if (Test-Path $env:ChocolateyInstall\lib-bkp\$packageName){
   Write-Warning "  * Upgrades are not supported. Please uninstall and reinstall the package."
   Write-Warning "  * Consider pinning this package to avoid attempted package updates and preserve your configuration:"
   Write-Warning "  * ""choco pin add -n=$packageName"""
   throw
  } 
  
#New-Item $unzipLocation -type directory | out-null

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# run Ubuntu-1604 installer in a new window
Set-Location -Path $unzipLocation
Start-Process ubuntu.exe

Write-Host "  **********************************************************************************" -foreground magenta
Write-Host "  * When you see ""Installation successful!"" in the other window, you may close it. *" -foreground magenta
Write-Host "  * Otherwise, just wait up to 25 seconds and it will close automatically.         *" -foreground magenta
Write-Host "  * Unsuccessful installs will abort and close automatically after 15 minutes.     *" -foreground magenta
Write-Host "  **********************************************************************************" -foreground magenta

# Make sure Ubuntu-1604 starts setting up and doesn't give an error
Start-Sleep -Seconds 5
if (Test-Path $unzipLocation\rootfs)
   {
# wait for Ubuntu-1604 installer to finish extracting files
    $LoopMePlease=0
    while (!(Test-Path $unzipLocation\rootfs\var\tmp)){
           Start-Sleep -Seconds 15
		   $LoopMePlease++
# break out of the loop after 15 minutes in case of error
		   if ($LoopMePlease -gt 60) { 
			  $SomethingWentWrong=$true
	          Write-Warning "Something went wrong. Possibly Ubuntu-1604 already installed or corrupt."
			  wslconfig /list
		      break
			 } 
          }
    } else {
	  Write-Warning "Something went wrong. Possibly you haven't rebooted since enabling WSL."
	  $SomethingWentWrong=$true
	 }

# wait 10 more seconds to make sure the files IN rootfs\var\tmp get extracted
if (!($SomethingWentWrong)) {Start-Sleep -Seconds 10}

# terminate ubuntu.exe ~when it hits the "Enter new UNIX username:" prompt (meaning installation has finished)
Start-CheckandStop "ubuntu"
Start-CheckandStop "wsl"

if ($SomethingWentWrong) {throw}

Install-BinFile -Name Ubuntu1604 -Path "$unzipLocation\ubuntu.exe"
# The normal prompting for creation of a default user and password is bypassed (aborted) by this script,
# necessitated for automated install.
Write-Host "  ** root is the default user upon running WSL/Ubuntu." -foreground magenta
wslconfig /list

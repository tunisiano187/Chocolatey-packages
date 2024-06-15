$ErrorActionPreference = 'Stop'
$packageName = 'ntfssecurity-psmodule'

$PSversion = $PSVersionTable.PSVersion.Major
if ($PSversion -lt "5")
   {
    Write-Warning "PowerShell < v5 detected."
	Write-Warning "$packageName installs via the PowerShell Gallery and thus PowerShell v5 is a prerequisite."
	Write-Warning "If PowerShell v5 was installed as a dependency, you need to reboot and reinstall this package."
	throw
   }

# Will fail if packageVersion is a revised version not matching module version, i.e. x.x.x.0020180101
if (Get-Module -ListAvailable -Name NTFSSecurity -ErrorAction SilentlyContinue){
     Update-Module "NTFSSecurity" -RequiredVersion "$env:packageVersion" -Force
   } else {
     Get-PackageProvider -Name NuGet -Force
     Install-Module -Name NTFSSecurity -Scope AllUsers -RequiredVersion $env:packageVersion -AllowClobber -Force
     Import-Module NTFSSecurity
   }

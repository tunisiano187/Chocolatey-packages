# WMF 3/4 only
if ($PSVersionTable.PSVersion -lt $(New-Object System.Version("5.0.0.0"))) {
  choco install dotnet4.5.1 -y
  choco upgrade powershell-packagemanagement --ignore-dependencies -y
}
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Value 1 -PropertyType "DWord" -Force | Out-Null
Write-Output "Internet explorer First run disables"

$refreshenv = Get-Command refreshenv -ea SilentlyContinue
if ($null -ne $refreshenv -and $refreshenv.CommandType -ne 'Application') {
  refreshenv # You need the Chocolatey profile installed for this to work properly (Choco v0.9.10.0+).
} else {
  Write-Warning "We detected that you do not have the Chocolatey PowerShell profile installed, which is necessary for 'refreshenv' to work in PowerShell."
}

Install-PackageProvider -Name NuGet -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
$Env:au_version = "master"

Write-Output "Build AU"
git clone -q https://github.com/chocolatey-community/chocolatey-au.git $Env:TEMP/au
# Copy-Item setup/build.ps1 -Destination $Env:TEMP/au/ -Force
. "$Env:TEMP/au/scripts/Install-AU.ps1" $Env:au_version

#choco install -y au
Write-Output "Build validator"
git clone -q https://github.com/chocolatey/package-validator.git $Env:TEMP/validator
cmd /c "%temp%/validator/build.bat"

Write-Output "Setup finished"
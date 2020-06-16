# WMF 3/4 only
if ($PSVersionTable.PSVersion -lt $(New-Object System.Version("5.0.0.0"))) {
  choco install dotnet4.5.1 -y
  choco upgrade powershell-packagemanagement --ignore-dependencies -y
}

$refreshenv = Get-Command refreshenv -ea SilentlyContinue
if ($refreshenv -ne $null -and $refreshenv.CommandType -ne 'Application') {
  refreshenv # You need the Chocolatey profile installed for this to work properly (Choco v0.9.10.0+).
} else {
  Write-Warning "We detected that you do not have the Chocolatey PowerShell profile installed, which is necessary for 'refreshenv' to work in PowerShell."
}

Install-PackageProvider -Name NuGet -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
$Env:au_version = "master"

Write-Host "Buid AU"
git clone -q https://github.com/majkinetor/au.git $Env:TEMP/au
$version = $(git log -1 --date=short)[2].split(' ')[-1].replace("-",".")
. "$Env:TEMP/au/scripts/Install-AU.ps1" $Env:au_version -Version $version

Write-Host "Build validator"
git clone -q https://github.com/chocolatey/package-validator.git $Env:TEMP/validator
cmd /c "%temp%/validator/build.bat"

Write-Host "Setup finished"
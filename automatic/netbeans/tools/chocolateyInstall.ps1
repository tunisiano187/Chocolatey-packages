$ErrorActionPreference = 'Stop'

# use Chocolatey helper to download the installer so it appears in the tools directory
# next to our bundled installer script.  We do not call Install-ChocolateyPackage
# directly because the `installer.ps1` script does the actual work.

$url           = 'https://github.com/Friends-of-Apache-NetBeans/netbeans-installers/releases/download/nb31-rc1/Apache-NetBeans-31-rc1.exe'
$checksum      = 'B5B17BCAE7293B4F82B63C049CA4BB9FB4E8656D587B2A658112DDEF873D7B44'
$checksumType  = 'sha256'

$toolsDir      = Split-Path -Parent $MyInvocation.MyCommand.Definition
$installerFile = Join-Path $toolsDir (Split-Path $url -Leaf)

$packageArgs = @{
    packageName  = $env:ChocolateyPackageName
    url          = $url
    fileType     = 'exe'
    fileFullPath = $installerFile
    checksum     = $checksum
    checksumType = $checksumType
}

# download and verify the executable
Get-ChocolateyWebFile @packageArgs

# execute the shipped installer script in silent mode
$installerScript = Join-Path $toolsDir 'installer.ps1'
if (-not (Test-Path $installerScript)) {
    Throw "installer.ps1 not found in $toolsDir"
}

Write-Host 'Running bundled installer script in silent mode'
Start-ChocolateyProcessAsAdmin -FilePath 'powershell' -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$installerScript`" -DeploymentType Install -DeployMode Silent" -Wait

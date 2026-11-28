$ErrorActionPreference = 'Stop'

# use Chocolatey helper to download the installer so it appears in the tools directory
# next to our bundled installer script.  We do not call Install-ChocolateyPackage
# directly because the `installer.ps1` script does the actual work.

$url           = 'https://github.com/Friends-of-Apache-NetBeans/netbeans-installers/releases/download/nb32/Apache-NetBeans-32.exe'
$checksum      = '2C5CB545742D407C28A4D021B0502B18835FBF5BC81BDB3E41B720279C411C63'
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

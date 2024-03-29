choco upgrade -y chocolatey checksum
choco install -y keepass.install vt-cli autohotkey

# http://techrena.net/disable-ie-set-up-first-run-welcome-screen/
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Value 1 -PropertyType "DWord" -Force | Out-Null
Write-Output "IE first run welcome screen has been disabled."

Write-Output 'Setting Windows Update service to Manual startup type.'
Set-Service -Name wuauserv -StartupType Manual

#Write-Output "Set DNS to Privacy"
#
#$DNSAddresses = @(
#  ([IPAddress]'9.9.9.9').IPAddressToString
#  ([IPAddress]'1.1.1.1').IPAddressToString
#  ([IPAddress]'2606:4700:4700::1111').IPAddressToString
#  ([IPAddress]'2606:4700:4700::1001').IPAddressToString
#)

#$(Get-DnsClientServerAddress).InterfaceIndex | Get-Unique | Sort-Object | ForEach-Object{
#        #Set-DnsClientServerAddress -InterfaceIndex $_ -ServerAddresses $DNSAddresses
#}
#$(Get-DnsClientServerAddress).ServerAddresses

Install-Module VirusTotalAnalyzer -Force
Install-Module -Name PowerShellForGitHub -Force
    $secureString = ("$env:github_api_key" | ConvertTo-SecureString -AsPlainText -Force)
    $cred = New-Object System.Management.Automation.PSCredential "username is ignored", $secureString
    Set-GitHubAuthentication -Credential $cred
    $secureString = $null # clear this out now that it's no longer needed
    $cred = $null # clear this out now that it's no longer needed
Set-GitHubConfiguration -DisableTelemetry
#. "$PSScriptRoot\au_setup.ps1"
import-module ".\scripts\au_extensions.psm1"
Write-Output "Installing Update-Metadata.ps1"
$moduleWormiesPath = "$Env:ProgramFiles\WindowsPowerShell\Modules\Wormies-AU-Helpers\public\Update-Metadata.ps1"
$moduleWormiesPath = Resolve-Path $moduleWormiesPath
Copy-Item scripts/Update-Metadata.ps1 $moduleWormiesPath
. $moduleWormiesPath

. .\scripts\Invoke-VirusTotalScan.ps1
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
RefreshEnv.cmd
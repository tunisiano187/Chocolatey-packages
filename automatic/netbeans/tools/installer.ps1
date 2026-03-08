<#
.SYNOPSIS
    This script performs the installation or uninstallation of Apache NetBeans IDE 20.
    # LICENSE #
    PowerShell App Deployment Toolkit - Provides a set of functions to perform common application deployment tasks on Windows.
    Copyright (C) 2017 - Sean Lillis, Dan Cunningham, Muhammad Mashwani, Aman Motazedian.
    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
    You should have received a copy of the GNU Lesser General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
.DESCRIPTION
    The script is provided as a template to perform an install or uninstall of an application(s).
    The script either performs an "Install" deployment type or an "Uninstall" deployment type.
    The install deployment type is broken down into 3 main sections/phases: Pre-Install, Install, and Post-Install.
    The script dot-sources the AppDeployToolkitMain.ps1 script which contains the logic and functions required to install or uninstall an application.
.PARAMETER DeploymentType
    The type of deployment to perform. Default is: Install.
.PARAMETER DeployMode
    Specifies whether the installation should be run in Interactive, Silent, or NonInteractive mode. Default is: Interactive. Options: Interactive = Shows dialogs, Silent = No dialogs, NonInteractive = Very silent, i.e. no blocking apps. NonInteractive mode is automatically set if it is detected that the process is not user interactive.
.PARAMETER AllowRebootPassThru
    Allows the 3010 return code (requires restart) to be passed back to the parent process (e.g. SCCM) if detected from an installation. If 3010 is passed back to SCCM, a reboot prompt will be triggered.
.PARAMETER TerminalServerMode
    Changes to "user install mode" and back to "user execute mode" for installing/uninstalling applications for Remote Destkop Session Hosts/Citrix servers.
.PARAMETER DisableLogging
    Disables logging to file for the script. Default is: $false.
.EXAMPLE
    PowerShell.exe .\Deploy-ApacheNetBeans20.ps1 -DeploymentType "Install" -DeployMode "NonInteractive"
.EXAMPLE
    PowerShell.exe .\Deploy-ApacheNetBeans20.ps1 -DeploymentType "Install" -DeployMode "Silent"
.EXAMPLE
    PowerShell.exe .\Deploy-ApacheNetBeans20.ps1 -DeploymentType "Install" -DeployMode "Interactive"
.EXAMPLE
    PowerShell.exe .\Deploy-ApacheNetBeans20.ps1 -DeploymentType "Uninstall" -DeployMode "NonInteractive"
.EXAMPLE
    PowerShell.exe .\Deploy-ApacheNetBeans20.ps1 -DeploymentType "Uninstall" -DeployMode "Silent"
.EXAMPLE
    PowerShell.exe .\Deploy-ApacheNetBeans20.ps1 -DeploymentType "Uninstall" -DeployMode "Interactive"
.NOTES
    Toolkit Exit Code Ranges:
    60000 - 68999: Reserved for built-in exit codes in Deploy-Application.ps1, Deploy-Application.exe, and AppDeployToolkitMain.ps1
    69000 - 69999: Recommended for user customized exit codes in Deploy-Application.ps1
    70000 - 79999: Recommended for user customized exit codes in AppDeployToolkitExtensions.ps1
.LINK
    http://psappdeploytoolkit.com
#>
[CmdletBinding()]
Param (
    [Parameter(Mandatory=$false)]
    [ValidateSet('Install','Uninstall','Repair')]
    [string]$DeploymentType = 'Install',
    [Parameter(Mandatory=$false)]
    [ValidateSet('Interactive','Silent','NonInteractive')]
    [string]$DeployMode = 'Interactive',
    [Parameter(Mandatory=$false)]
    [switch]$AllowRebootPassThru = $false,
    [Parameter(Mandatory=$false)]
    [switch]$TerminalServerMode = $false,
    [Parameter(Mandatory=$false)]
    [switch]$DisableLogging = $false
)

Try {
    ## Set the script execution policy for this process
    Try { Set-ExecutionPolicy -ExecutionPolicy 'ByPass' -Scope 'Process' -Force -ErrorAction 'Stop' } Catch {}

    ##*===============================================
    ##* VARIABLE DECLARATION
    ##*===============================================
    ## Variables: Application
    [string]$appVendor = 'Apache'
    [string]$appName = 'NetBeans IDE'
    [string]$appVersion = '20'
    [string]$appArch = ''
    [string]$appLang = ''
    [string]$appRevision = ''
    [string]$appScriptVersion = '1.0.0'
    [string]$appScriptDate = 'XX/XX/20XX'
    [string]$appScriptAuthor = 'Jason Bergner'
    ##*===============================================
    ## Variables: Install Titles (Only set here to override defaults set by the toolkit)
    [string]$installName = ''
    [string]$installTitle = 'Apache NetBeans IDE 20'

    ##* Do not modify section below
    #region DoNotModify

    ## Variables: Exit Code
    [int32]$mainExitCode = 0

    ## Variables: Script
    [string]$deployAppScriptFriendlyName = 'Deploy Application'
    [version]$deployAppScriptVersion = [version]'3.8.4'
    [string]$deployAppScriptDate = '26/01/2021'
    [hashtable]$deployAppScriptParameters = $psBoundParameters

    ## Variables: Environment
    If (Test-Path -LiteralPath 'variable:HostInvocation') { $InvocationInfo = $HostInvocation } Else { $InvocationInfo = $MyInvocation }
    [string]$scriptDirectory = Split-Path -Path $InvocationInfo.MyCommand.Definition -Parent

    ## Dot source the required App Deploy Toolkit Functions
    Try {
        [string]$moduleAppDeployToolkitMain = "$scriptDirectory\AppDeployToolkit\AppDeployToolkitMain.ps1"
        If (-not (Test-Path -LiteralPath $moduleAppDeployToolkitMain -PathType 'Leaf')) { Throw "Module does not exist at the specified location [$moduleAppDeployToolkitMain]." }
        If ($DisableLogging) { . $moduleAppDeployToolkitMain -DisableLogging } Else { . $moduleAppDeployToolkitMain }
    }
    Catch {
        If ($mainExitCode -eq 0){ [int32]$mainExitCode = 60008 }
        Write-Error -Message "Module [$moduleAppDeployToolkitMain] failed to load: `n$($_.Exception.Message)`n `n$($_.InvocationInfo.PositionMessage)" -ErrorAction 'Continue'
        ## Exit the script, returning the exit code to SCCM
        If (Test-Path -LiteralPath 'variable:HostInvocation') { $script:ExitCode = $mainExitCode; Exit } Else { Exit $mainExitCode }
    }

    #endregion
    ##* Do not modify section above
    ##*===============================================
    ##* END VARIABLE DECLARATION
    ##*===============================================

    If ($deploymentType -ine 'Uninstall' -and $deploymentType -ine 'Repair') {
        ##*===============================================
        ##* PRE-INSTALLATION
        ##*===============================================
        [string]$installPhase = 'Pre-Installation'

        ## Microsoft Intune Win32 App Workaround - Check If Running 32-bit Powershell on 64-bit OS, Restart as 64-bit Process
        If (!([Environment]::Is64BitProcess)){
        If([Environment]::Is64BitOperatingSystem){

        Write-Log -Message "Running 32-bit Powershell on 64-bit OS, Restarting as 64-bit Process..." -Severity 2
        $Arguments = "-NoProfile -ExecutionPolicy ByPass -WindowStyle Hidden -File `"" + $myinvocation.mycommand.definition + "`""
        $Path = (Join-Path $Env:SystemRoot -ChildPath "\sysnative\WindowsPowerShell\v1.0\powershell.exe")

        Start-Process $Path -ArgumentList $Arguments -Wait
        Write-Log -Message "Finished Running x64 version of PowerShell"
        Exit

        }Else{
        Write-Log -Message "Running 32-bit Powershell on 32-bit OS"
        }
        }

        ## Show Welcome Message, Close Apache NetBeans With a 60 Second Countdown Before Automatically Closing
        Show-InstallationWelcome -CloseApps 'java,netbeans,netbeans64' -CloseAppsCountdown 60

        ## Show Progress Message (With a Message to Indicate the Application is Being Uninstalled)
        Show-InstallationProgress -StatusMessage "Removing Any Existing Versions of $installTitle. Please Wait..."

        ## Detect and resolve a known exception that occurs when a damaged Apache NetBeans registry entry breaks the Uninstall query functionality.
        ## https://issues.apache.org/jira/browse/NETBEANS-2523
        Try {
        Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*','HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' -ErrorAction Stop | Out-Null
        } Catch [System.InvalidCastException] {
        $NetBeans = (& reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall" | Where-Object {$_ -match 'nbi\-'})

        ForEach ($entry in $NetBeans) {
        $registryPath = $entry -replace 'HKEY_LOCAL_MACHINE', 'HKLM:'
        & reg add $entry /v NoModify /t REG_DWORD /d 0x1 /f | Out-Null
        }
        }

        ## Remove Any Existing Version of Apache NetBeans IDE 20 (Originally Installed by User)
        $appList = Get-InstalledApplication -Name 'Apache NetBeans IDE 20'
        ForEach ($app in $appList)
        {
        If($app.UninstallString)
        {
        $uninstPath = $($app.UninstallString).Replace('"','')
        If(Test-Path -Path $uninstPath)
        {
        Write-Log -Message "Found $($app.DisplayName) $($app.DisplayVersion) and a valid uninstall string, now attempting to uninstall."
        Execute-ProcessAsUser -Path $uninstPath -Parameters "--silent" -Wait
        Start-Sleep -Seconds 5
        }
        }
        }

        ## Remove Any Existing Version of Apache NetBeans IDE 20 (Originally Installed by System)
        $appList = Get-InstalledApplication -Name 'Apache NetBeans IDE 20'
        ForEach ($app in $appList)
        {
        If($app.UninstallString)
        {
        $uninstPath = $($app.UninstallString).Replace('"','')
        If(Test-Path -Path $uninstPath)
        {
        Write-Log -Message "Found $($app.DisplayName) $($app.DisplayVersion) and a valid uninstall string, now attempting to uninstall."
        Execute-Process -Path $uninstPath -Parameters "--silent"
        Start-Sleep -Seconds 5
        }
        }
        }

        ##*===============================================
        ##* INSTALLATION
        ##*===============================================
        [string]$installPhase = 'Installation'

        If ($ENV:PROCESSOR_ARCHITECTURE -eq 'x86'){
        Write-Log -Message "Detected 32-bit OS Architecture. Apache NetBeans 20 is not supported on 32-bit operating systems." -Severity 2 -Source $deployAppScriptFriendlyName

        }
        Else
        {
        Write-Log -Message "Detected 64-bit OS Architecture" -Severity 1 -Source $deployAppScriptFriendlyName

        ## Install Java JDK 64-bit
        $msiPath = Get-ChildItem -Path "$dirFiles" -Include jdk-*_windows-x64_bin.msi -File -Recurse -ErrorAction SilentlyContinue
        $transform = Get-ChildItem -Path "$dirFiles" -Include *.mst -File -Recurse -ErrorAction SilentlyContinue

        If(($msiPath.Exists) -and ($transform.Exists))
        {
        Write-Log -Message "Found $($msiPath.FullName) and $($transform.FullName), now attempting to install Java JDK 64-bit."
        Show-InstallationProgress "Installing Java JDK 64-bit. This may take some time. Please wait..."
        Execute-MSI -Action Install -Path "$msiPath" -AddParameters "TRANSFORMS=$transform"
        }
        ElseIf ($msiPath.Exists)
        {
        Write-Log -Message "Found $($msiPath.FullName), now attempting to install Java JDK 64-bit."
        Show-InstallationProgress "Installing Java JDK 64-bit. This may take some time. Please wait..."
        Execute-MSI -Action Install -Path "$msiPath" -AddParameters "ALLUSERS=1"
        }

        ## Install Apache NetBeans IDE 20
        $exePath = Get-ChildItem -Path "$dirFiles" -Include Apache-NetBeans-20*-bin-windows-x64.exe -File -Recurse -ErrorAction SilentlyContinue
        $xml = Get-ChildItem -Path "$dirFiles" -Include state.xml -File -Recurse -ErrorAction SilentlyContinue

        If(($exePath.Exists) -and ($xml.Exists))
        {
        Write-Log -Message "Found $($exePath.FullName) and $($xml.FullName), now attempting to install $installTitle."
        Show-InstallationProgress "Installing Apache NetBeans IDE 20. This may take some time. Please wait..."
        Execute-Process -Path "$exePath" -Parameters "--silent --state ""$xml""" -WindowStyle Hidden
        Start-Sleep -Seconds 5

        ## Suppress & Disable Usage Statistics Prompt
        $config = Get-ChildItem -Path "$dirFiles" -Include core.properties -File -Recurse -ErrorAction SilentlyContinue

        If ($config.Exists) {
        Write-Log -Message "Found $($config.FullName), now attempting to copy the core.properties file."

        $NetBeansVersions = @("20.9", "20.8", "20.7", "20.6", "20.5", "20.4", "20.3", "20.2", "20.1", "20")

        $userProfiles = Get-WmiObject Win32_UserProfile | Where-Object {(!$_.Special) -and $_.LocalPath -notlike 'C:\Windows\ServiceProfiles*'} | Select-Object -ExpandProperty LocalPath

        ForEach ($profile in $userProfiles) {
        ForEach ($version in $NetBeansVersions) {
        $NetBeansPath = Join-Path $profile "AppData\Roaming\NetBeans\$Version\config\Preferences\org\netbeans\"

        If (Test-Path -Path "$envProgramFiles\NetBeans-$version\") {
        New-Item -Path $NetBeansPath -ItemType Directory -Force
        Copy-Item -Path $config.FullName -Destination $NetBeansPath -ErrorAction SilentlyContinue
        }
        }
        }
        }

        } else {
        Write-Log -Message "Apache NetBeans IDE 20 installer or state.xml response file were not found. Installation aborted." -Severity 2
        Show-InstallationPrompt -Message "Apache NetBeans IDE 20 installer or state.xml response file were not found. Installation aborted." -ButtonRightText "OK"
        }
        }

        ##*===============================================
        ##* POST-INSTALLATION
        ##*===============================================
        [string]$installPhase = 'Post-Installation'

    }
    ElseIf ($deploymentType -ieq 'Uninstall')
    {
        ##*===============================================
        ##* PRE-UNINSTALLATION
        ##*===============================================
        [string]$installPhase = 'Pre-Uninstallation'

        ## Show Welcome Message, Close Apache NetBeans With a 60 Second Countdown Before Automatically Closing
        Show-InstallationWelcome -CloseApps 'java,netbeans,netbeans64' -CloseAppsCountdown 60

        ## Show Progress Message (With a Message to Indicate the Application is Being Uninstalled)
        Show-InstallationProgress -StatusMessage "Uninstalling $installTitle. Please Wait..."

        ##*===============================================
        ##* UNINSTALLATION
        ##*===============================================
        [string]$installPhase = 'Uninstallation'

        ## Detect and resolve a known exception that occurs when a damaged Apache NetBeans registry entry breaks the Uninstall query functionality.
        ## https://issues.apache.org/jira/browse/NETBEANS-2523
        Try {
        Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*','HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' -ErrorAction Stop | Out-Null
        } Catch [System.InvalidCastException] {
        $NetBeans = (& reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall" | Where-Object {$_ -match 'nbi\-'})

        ForEach ($entry in $NetBeans) {
        $registryPath = $entry -replace 'HKEY_LOCAL_MACHINE', 'HKLM:'
        & reg add $entry /v NoModify /t REG_DWORD /d 0x1 /f | Out-Null
        }
        }

        ## Uninstall Any Existing Version of Apache NetBeans IDE 20 (Originally Installed by User)
        $appList = Get-InstalledApplication -Name 'Apache NetBeans IDE 20'
        ForEach ($app in $appList)
        {
        If($app.UninstallString)
        {
        $uninstPath = $($app.UninstallString).Replace('"','')
        If(Test-Path -Path $uninstPath)
        {
        Write-Log -Message "Found $($app.DisplayName) $($app.DisplayVersion) and a valid uninstall string, now attempting to uninstall."
        Execute-ProcessAsUser -Path $uninstPath -Parameters "--silent" -Wait
        Start-Sleep -Seconds 5
        }
        }
        }

        ## Uninstall Any Existing Version of Apache NetBeans IDE 20 (Originally Installed by System)
        $appList = Get-InstalledApplication -Name 'Apache NetBeans IDE 20'
        ForEach ($app in $appList)
        {
        If($app.UninstallString)
        {
        $uninstPath = $($app.UninstallString).Replace('"','')
        If(Test-Path -Path $uninstPath)
        {
        Write-Log -Message "Found $($app.DisplayName) $($app.DisplayVersion) and a valid uninstall string, now attempting to uninstall."
        Execute-Process -Path $uninstPath -Parameters "--silent"
        Start-Sleep -Seconds 5
        }
        }
        }

        ##*===============================================
        ##* POST-UNINSTALLATION
        ##*===============================================
        [string]$installPhase = 'Post-Uninstallation'


    }
    ElseIf ($deploymentType -ieq 'Repair')
    {
        ##*===============================================
        ##* PRE-REPAIR
        ##*===============================================
        [string]$installPhase = 'Pre-Repair'


        ##*===============================================
        ##* REPAIR
        ##*===============================================
        [string]$installPhase = 'Repair'


        ##*===============================================
        ##* POST-REPAIR
        ##*===============================================
        [string]$installPhase = 'Post-Repair'


    }
    ##*===============================================
    ##* END SCRIPT BODY
    ##*===============================================

    ## Call the Exit-Script function to perform final cleanup operations
    Exit-Script -ExitCode $mainExitCode
}
Catch {
    [int32]$mainExitCode = 60001
    [string]$mainErrorMessage = "$(Resolve-Error)"
    Write-Log -Message $mainErrorMessage -Severity 3 -Source $deployAppScriptFriendlyName
    Show-DialogBox -Text $mainErrorMessage -Icon 'Stop'
    Exit-Script -ExitCode $mainExitCode
}

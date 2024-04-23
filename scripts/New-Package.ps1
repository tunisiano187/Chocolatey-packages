<#
.SYNOPSIS
    Create and prepare to add a package in the automatic folder

.DESCRIPTION
    Create the package folder in the automatic folder, create the nuspec and the tools folder.
    Add the Readme.md file

.PARAMETER packageName
    the package to create

.PARAMETER folder
    The folder where the packages are
    Default : automatic\

.PARAMETER iconfolder
    The folder where we're adding the icons
    Default : icons\

.OUTPUTS
    A folder containing the main files and the icon if that's available

.DEVELOPMENT informations
    Vars

    $nupkg : Temp path ($env:TEMP\packageName)
    $work... : vars for the working environment directories and files
    $workcontent... : vars containing the files content

#>
param(
    [Parameter(Mandatory = $true)]
    [string]$packageName,
    [string]$folder = 'automatic',
    [string]$iconfolder = 'icons'
)

$ErrorActionPreference = "Stop";

$folder=Join-Path $PSScriptRoot $folder
if ($folder -match "scripts") {
    $folder = $folder -replace "\\scripts", ""
}

$parentfolder   = $folder -replace "\\[^\\]+$", ""
$iconfolder     = Join-Path $parentfolder $iconfolder

$icon           = "$iconfolder\$packageName"
$PackageFolder  = "$folder\$packageName\"

if(Test-Path "$folder\$packageName\") {
    $replace = Read-Host -Prompt "the package already exist in the destination folder, do you want to replace it ? Y/[N]"
    if($replace.ToLower() -eq "y") {
        Remove-Item "$folder\$packageName\" -Force -Recurse
        Remove-Item "$nupkg.zip" -Force
    } else {
        Exit 0;
    }
}

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco new $packageName -a --version 0.0 maintainername="'tunisiano'" --outputdirectory $folder

Install-Module wormies-au-helpers -Force
$TemplateFolder = Join-Path $parentfolder 'scripts/templates'
$TemplateReadMe = Join-Path $TemplateFolder "README.md"
$ReadmeContent = Get-Content $TemplateReadMe
$ReadmeContent = $ReadmeContent -replace "pkgid",$packageName.ToLower()

Set-Content -Path "$PackageFolder\README.md" -Value $ReadmeContent

"git pull"
git pull

"List files to add to git"
$toadd = (get-childitem -path "$folder\$packageName").FullName
foreach ($file in $toadd) {
    if($file -notmatch "exe" -and $file -notmatch "zip" -and $file -notmatch "msi") {
        git add $file
    }
}
$toadd = (get-childitem -path $iconfolder).FullName
foreach ($file in $toadd) {
    git add $file
}

git config user.email "helpdesk.choc@gmail.com"
git config user.name "Tunisiano187"

git commit -m "Create Package $packageName
[skip ci]"

try {
    git push
} catch {
    write-output "nothing to push"
}
<#
.SYNOPSIS
    Download and prepare to add a package in the automatic folder

.DESCRIPTION
    Download the nupkg, expand it, create the package folder in
    the automatic folder, copy the nuspec and the tools, download the icon

.PARAMETER packageName
    the package to download

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

"Get-package : Package Name : $packageName"
if($null -eq $packageName) {
    throw "Package Name empty"
}

git pull
git branch $packageName
$folder=Join-Path $PSScriptRoot $folder
if ($folder -match "scripts") {
    $folder = $folder -replace "\\scripts", ""
}

$parentfolder   = $folder -replace "\\[^\\]+$", ""
$iconfolder     = Join-Path $parentfolder $iconfolder

$icon           = "$iconfolder\$packageName"
$nuspecPath     = "$folder\$packageName\$packageName.nuspec"
$PackageFolder  = "$folder\$packageName\"

if(Test-Path "$folder\$packageName\") {
    $replace = Read-Output -Prompt "the package already exist in the destination folder, do you want to replace it ? Y/[N]"
    if($replace.ToLower() -eq "y") {
        Remove-Item "$folder\$packageName\" -Force -Recurse
        Remove-Item "$nupkg.zip" -Force
    } else {
        Exit 0;
    }
}

try {
    Import-Module PSGithubSearch
}
catch {
    Install-Module PSGithubSearch
    Import-Module PSGithubSearch
}

# Preparing the work Folder
$workfolder         = Join-Path -Path $env:TEMP -ChildPath "Scripts\WorkDir"
$WorkNuspec         = Join-Path -Path $workfolder -ChildPath "$packageName.nuspec"
$nupkgZip           = Join-Path -Path $env:TEMP -ChildPath "Scripts\$packageName.zip"


New-Item -ItemType Directory -Path $workfolder -Force
# Try to download the nupkg
try {
    Invoke-WebRequest -Uri "https://community.chocolatey.org/api/v2/package/$($packageName)" -OutFile $nupkgZip
}
catch {
    Write-Output "An error occurred:"
    Write-Output $_
}

if(!(Test-Path $nupkgZip)) {
    Throw "Unable to download $packageName from the community repository";
}

# Expand file To work folder and remove the temp file
Expand-Archive -Path $nupkgZip -DestinationPath $workfolder -Force
Remove-Item $nupkgZip -Force

# Check if nuspec is present
if(!(Test-Path $workNuspec)) {
    Throw "Unable to find $workNuspec";
}

# Loading Nuspec to var
[xml]$WorkContentNuspec = New-Object System.Xml.XmlDocument
[xml]$WorkContentNuspec = Get-Content $workNuspec

# Check if the nuspec has an iconUrl and download the icon directly to the right folder
if($WorkContentNuspec.package.metadata.iconUrl) {
    $iconfile = "$icon.$(($WorkContentNuspec.package.metadata.iconUrl).split('.')[-1])"
    try {
        Invoke-WebRequest -Uri $WorkContentNuspec.package.metadata.iconUrl -OutFile $iconfile
    }
    catch {
        "Unable to download picture from $($WorkContentNuspec.package.metadata.iconUrl)"
    }
} else {
    if($WorkContentNuspec.package.metadata.iconUrl -match "bcurran3") {
        try {
            $iconbcurran = ($WorkContentNuspec.package.metadata.iconUrl).replace('master','master/_NO_LONGER_MAINTAINED_')
            Invoke-WebRequest -Uri $iconbcurran -OutFile $iconfile
        }
        catch {
            "Unable to download picture from $($WorkContentNuspec.package.metadata.iconUrl)"
        }
    }
        Write-Output "Icon not found in the Nuspec"
}

# Check if the icon is present and download it directly from the community repository if not
if(!(Test-Path $icon)) {
    $pageContent = Invoke-WebRequest -Uri "https://community.chocolatey.org/packages/$($packageName)"
    $regexPattern = '(?<=&lt;iconUrl&gt;).*?(?=&lt;/iconurl&gt;)'
    $urlMatch = $pageContent.Content | Select-String -Pattern $regexPattern -AllMatches
    if ($urlMatch.Matches.Count -gt 0) {
        try {
            Invoke-WebRequest -Uri $urlMatch.Matches[0].Value -OutFile "$icon.$(($urlMatch.Matches[0].Value).split('.')[-1])"
        }
        catch {
            "Unable to download picture from $($urlMatch.Matches[0].Value)"
        }
    }
}

## Check if the nuspec has a version and set it to 0.0
#if($WorkContentNuspec.package.metadata.Version) {
#    Update-Metadata -NuspecFile $workNuspec -key "version" -value "0.0"
#}

# Check if the packageSourceUrl is set and is a Github repository
if($WorkContentNuspec.package.metadata.packageSourceUrl) {
    $PackageSourceUrl = $WorkContentNuspec.package.metadata.packageSourceUrl
}
if($PackageSourceUrl -match "://github.com") {
    $GHRawUrl = $PackageSourceUrl -replace "github.com","raw.githubusercontent.com"

    # Download the update.ps1 file if it is available
    try {
        Invoke-WebRequest -Uri "$GHRawUrl/update.ps1" -OutFile "$workfolder\update.ps1.old"
    }
    catch {
        "No update.ps1 file available"
    }

    # Download the Readme file if it is available
    try {
        Invoke-WebRequest -Uri "$GHRawUrl/README.md" -OutFile "$workfolder\README.md"
    }
    catch {
        "No README.md file available"
    }
} # elseif (!$WorkContentNuspec.package.metadata.packageSourceUrl) {
    # Add packageSourceUrl element if missing
#        $child = $xmlDoc.CreateElement("packageSourceUrl")
#        $WorkContentNuspec.package.metadata.AppendChild($child)
#}

# Preparing the destination Folder
New-Item -ItemType Directory -Path "$folder\$packageName" -Force
"Saving nuspec to $folder\$packageName\$packageName.nuspec"

$WorkContentNuspec.Save($nuspecPath)

"Check if the element <files> exist in the nuspec"
if (!($WorkContentNuspec -match "<files>")) {
    Write-Output 'Add <files>...</files>'
    (Get-Content $NuspecPath) -replace "</package>", '  <files>
    <file src="tools\**" target="tools" />
  </files>
</package>' | Set-Content $NuspecPath
}

"Check if the element <packageSourceUrl> exist in the nuspec"
if(!($WorkContentNuspec.package.metadata.packageSourceUrl)) {
    Write-Output "add packageSourceUrl"
    (Get-Content $NuspecPath) -replace "</owners>", '</owners>
<packageSourceUrl></packageSourceUrl>' | Set-Content $NuspecPath
}

# "Set version to 0.0"
#Update-Metadata -NuspecFile $NuspecPath -key "version" -value "0.0"

# Moving files to the final destination

if(Test-Path "$workfolder\tools") {
    Remove-Item -Path "$workfolder\tools" -Include "*.exe"
    Get-ChildItem -Path "$workfolder\tools" | Where-Object {$_.Length -gt 1mb} | Remove-Item -Force -Recurse
    New-Item -ItemType Directory -Path "$PackageFolder\tools" -Force
    Move-Item -Path "$workfolder\tools" -Destination "$PackageFolder" -Exclude "*.zip" -Force
}

if(Test-Path "$workfolder\update.ps1") {
    Move-Item -Path "$workfolder\update.ps1.old" -Destination "$PackageFolder\update.ps1.old"
}

if(Test-Path "$workfolder\README.md") {
    Move-Item -Path "$workfolder\README.md" -Destination "$PackageFolder\README.md"
} else {
    Install-Module wormies-au-helpers -Force
    $TemplateFolder = Join-Path $parentfolder 'scripts/templates'
    $TemplateReadMe = Join-Path $TemplateFolder "README.md"
    $ReadmeContent = Get-Content $TemplateReadMe
    "File $TemplateReadMe exist ? $(Test-Path $TemplateReadMe)"
    $ReadmeContent = $ReadmeContent -replace "pkgid",$packageName.ToLower()
    $ReadmeContent = $ReadmeContent -replace "PKGTITLE",$WorkContentNuspec.package.metadata.title
    $ReadmeContent = $ReadmeContent -replace "PKGDesc",$WorkContentNuspec.package.metadata.description

    Set-Content -Path "$PackageFolder\README.md" -Value $ReadmeContent
}


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

git commit -m "Package download $packageName
[skip ci]"

try {
    git push
} catch {
    write-output "nothing to push"
}
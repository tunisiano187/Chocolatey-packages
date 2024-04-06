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
    Default : ..\automatic\

.PARAMETER iconfolder
    The folder where we're adding the icons
    Default : ..\icons\

.OUTPUTS
    A folder containing the main files and the icon if that's available
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$packageName,
    [string]$folder = 'automatic\',
    [string]$iconfolder = 'icons\'
)
#$ErrorActionPreference = "Stop";

$nupkg = "$env:TEMP/$($packageName)"
$icon = "$iconfolder\$packageName"

if(Test-Path "$folder\$packageName\") {
    $replace = Read-Host -Prompt "the package already exist in the destination folder, do you want to replace it ? Y/[N]"
    if($replace.ToLower() -eq "y") {
        Remove-Item "$folder\$packageName\" -Force -Recurse
        Remove-Item "$nupkg.zip" -Force
    } else {
        Exit 0;
    }
}

Install-Module PSGithubSearch
Import-Module PSGithubSearch

# Try to download the nupkg
Invoke-WebRequest -Uri "https://community.chocolatey.org/api/v2/package/$($packageName)" -OutFile "$nupkg.zip"

if(Test-Path "$nupkg.zip") {
    # Expand file
    Expand-Archive -Path "$nupkg.zip" -DestinationPath $nupkg -Force
    Remove-Item "$nupkg.zip" -Force
    New-Item -ItemType Directory -Name $packageName.ToLower() -Path "$folder" -Force

    $nuspecPath = "$folder\$packageName\$packageName.nuspec"
    # read nuspec
    [xml]$nuspec = New-Object System.Xml.XmlDocument
    [xml]$nuspec = Get-Content "$folder\$packageName\$packageName.nuspec"

    # Check if the nuspec has an iconUrl and download the icon to the right folder
    
    if($nuspec.package.metadata.iconUrl) {
        $icon = "$iconfolder\$packageName.$(($nuspec.package.metadata.iconUrl).split('.')[-1])"
        Invoke-WebRequest -Uri $nuspec.package.metadata.iconUrl -OutFile $icon
    } else {
        Write-Output "Icon not found in the Nuspec"
    }
    if(!Test-Path $icon) {
        $pageContent = Invoke-WebRequest -Uri "https://community.chocolatey.org/packages/$($packageName)"
        $regexPattern = '(?<=&lt;iconUrl&gt;).*?(?=&lt;/iconurl&gt;)'
        $urlMatch = $pageContent.Content | Select-String -Pattern $regexPattern -AllMatches
        if ($urlMatch.Matches.Count -gt 0) {
            Invoke-WebRequest -Uri $urlMatch.Matches[0].Value -OutFile "$iconfolder\$packageName.$(($urlMatch.Matches[0].Value).split('.')[-1])"
        }
    }

    # Check if the nuspec has a version and set it to 0.0
    if($nuspec.package.metadata.Version) {
        $nuspec.package.metadata.Version = "0.0"
    }

    $packagesourceurl = $($nuspec.package.metadata.packageSourceUrl).split('/')[3]

    if($nuspec.package.metadata.packageSourceUrl -and $nuspec.package.metadata.packageSourceUrl -match $packageName) {
        if($nuspec.package.metadata.packageSourceUrl -match 'github' -or $nuspec.package.metadata.packageSourceUrl -match 'gitlab') {

            try {
                $readmelink = (Find-GitHubCode -user $packagesourceurl -Extension 'md' -Keywords $packageName -ErrorAction SilentlyContinue | Where-Object {$_ -imatch 'readme'}).html_url.replace('blob','raw')
                Invoke-WebRequest -Uri $readmelink -OutFile "$folder\$packageName\ReadMe.md" -ErrorAction SilentlyContinue
            } catch {
                Write-Output "No Readme found in $packagesourceurl"
            }

            try {
                $LICENSElink = (Find-GitHubCode -user $packagesourceurl -Extension 'txt' -Keywords $packageName -ErrorAction SilentlyContinue | Where-Object {$_ -imatch 'LICENSE'}).html_url.replace('blob','raw')
                Invoke-WebRequest -Uri $LICENSElink -OutFile "$folder\$packageName\tools\LICENSE.txt" -ErrorAction SilentlyContinue
            } catch {
                Write-Output "No LICENSE found in $packagesourceurl"
            }

            try {
                $VERIFICATIONlink = (Find-GitHubCode -user $packagesourceurl -Extension 'txt' -Keywords $packageName -ErrorAction SilentlyContinue | Where-Object {$_ -imatch 'VERIFICATION'}).html_url.replace('blob','raw')
                Invoke-WebRequest -Uri $VERIFICATIONlink -OutFile "$folder\$packageName\tools\VERIFICATION.txt" -ErrorAction SilentlyContinue
            } catch {
                Write-Output "No VERIFICATION found in $packagesourceurl"
            }

            try {
                $updatelink = (Find-GitHubCode -user $packagesourceurl -Extension 'ps1' -Keywords $packageName -ErrorAction SilentlyContinue | Where-Object {$_ -imatch 'update'}).html_url.replace('blob','raw')
                $updatefile="$folder\$packageName\update.ps1.bak"
                Invoke-WebRequest -Uri $updatelink -OutFile $updatefile -ErrorAction SilentlyContinue
                (Get-Content $updatefile) -replace "legal","tools" | Set-Content $updatefile
            } catch {
                Write-Output "No update.ps1 found in $packagesourceurl"
            }
        }
    } elseif (!$nuspec.package.metadata.packageSourceUrl) {
        # Add packageSourceUrl element if missing
            $child = $xmlDoc.CreateElement("packageSourceUrl")
            $nuspec.package.metadata.AppendChild($child)
    }

    $output = ($nuspec | Out-String) -replace '\r\n?',"`n"
    [System.IO.File]::WriteAllText("$folder\$packageName\$packageName.nuspec", $output, $encoding);

    # Check if the element <files> exist in the nuspec
if (!($nuspecContent.Contains("<files>"))) {
    Write-Output 'Add <files>...</files>'
    $nuspecContent = $nuspecContent -replace '</package>', '  <files>
    <file src="tools\**" target="tools" />
  </files>
</package>'

    # Save the update
    Set-Content -Path $nuspecPath.FullName -Value $nuspecContent
    Write-Output "The lines <files>...</files> have been added to the nuspec."
}
    if(!($nuspec.package.metadata.packageSourceUrl)) {
        Write-Output "add packageSourceUrl"
        (Get-Content $NuspecPath) -replace "</owners>", '</owners>
    <packageSourceUrl></packageSourceUrl>' | Set-Content $NuspecPath
    }
    Write-Output "Set version to 0.0"
    Update-Metadata -NuspecFile $NuspecPath -key "version" -value "0.0"

    # copy required files in the new folder
    Copy-Item -Path "$nupkg\$packageName.nuspec" -Destination "$folder\$packageName\" -Recurse

    if(Test-Path "$nupkg\tools") {
        Remove-Item -Path "$nupkg\tools" -Include "*.exe"
        Get-ChildItem -Path "$nupkg\tools" | Where-Object {$_.Length -gt 1mb} | Remove-Item -Force -Recurse
        Move-Item -Path "$nupkg\tools" -Destination "$folder\$packageName\" -Exclude "*.zip" -Force
    }

    Write-Output "git pull"
    git pull

    Write-Output "List files to add to git"
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
    git commit -m "Package download $packageName"
    try {
        $PushURL = $env:gitlab_PushURL

        $origin  = git config --get remote.origin.url
        ### Construct RepoURL to be set as new origin
        $RepoURL = (
            $PushURL.split('://')[0] `
            + "://" `
            + $env:gitlab_user `
            + ":" `
            + $env:gitlab_api_key `
            + "@" `
            + $PushURL.TrimStart(
                $(
                    $PushURL.split('://')[0] `
                    + "://"
                )
            )
        )

        ### Set new push URL
        git remote set-url origin $RepoURL

        ### Ensure local is up-to-date to avoid conflicts
        Write-Output "Executing git pull"
        git checkout -q $Branch
        git pull -q origin $Branch
        ### Push
        Write-Output "Pushing changes"
        git push -q
        git remote set-url origin $origin
    } catch {
        write-output "nothing to push"
    }
}

$ErrorActionPreference = 'Continue';

# Requisites
Install-Module psgithubsearch -ErrorAction SilentlyContinue
Import-Module psgithubsearch
if(!(Test-Path Env:github_api_key)) {
    $Env:github_api_key   = $Github_personal_token          #Github personal access token
}
[string]$Owner = "tunisiano187"
[string]$Repository = "Chocolatey-packages"
$UserToken = $env:github_api_key
$Headers = @{
    Authorization='token '+$UserToken
}
$search = ''
$version = ''

# Check if there is a waiting issue
if(Find-GitHubIssue -Type issue -Repo "$Owner/$Repository" -State open) {
    Write-Warning "Some issues are still open"
    Write-Warning "Not checking for broken packages"
    exit 0;
}
# Wait to avoid api requests limit
Start-Sleep 10;

# Check if one package is waiting for maintainer action on Chocolatey
if($Todo.Count -eq 0) {
    $chocoprofile = "https://chocolatey.org/profiles/tunisiano"
    $links = ((Invoke-WebRequest -Uri $chocoprofile -UseBasicParsing).links | Where-Object {$_.outerHTML -match "maintainer"}).href
    $Todo=$links.split('/')[-2]
    $version="/$($links.split('/')[-1])"
}

# If no package is waiting
# Take a package that needs action on the Todo repository (Mostly dtgm packages)
if($Todo.Count -eq 0) {
    Invoke-WebRequest -uri https://gitlab.com/chocolatey-packages/todo/-/raw/master/README.md -OutFile "$($env:TEMP)\list.txt"
    $Todo=$(Get-Content "$($env:TEMP)\list.txt" | Where-Object {$_ -notmatch '#'} | Where-Object {$_ -notmatch 'Count' } | Where-Object {$_ -notmatch '--'} | Select-Object -First 1).split('|')[-2]
    $ToDo=$ToDo.Trim()
}

# If no package is waiting
# Take a package that is requested on the chocolatey-package-requests
if($Todo.Count -eq 0) {
    $ToDo = Find-GitHubIssue -Type issue -Repo "chocolatey-community/chocolatey-package-requests" -State open -No assignee -SortBy updated | Where-Object {$_.Labels -match 'maint'} | Where-Object {$_.Title -match 'RFM'} | Select-Object -First 1
    $ToDo = $ToDo.Title.split(' ')[-1]
}

# Clean the search item
$ToDo=$ToDo.trim()
# Check if there is already a closed issue about this request and avoid search
if($ToDo.Count -gt 0){
    $search = $ToDo
    $closed = Find-GitHubIssue -Type issue -Repo "$Owner/$Repository" -State closed -Keywords $search
    if($closed.Count -gt 0) {
        $search = ''
    }
}

# if the search var is empty, search in the list.txt file (obtained by seaching for [outdated] term)
if($search -eq '') {
    $source = Join-Path $PSScriptRoot "Check/list.txt"
    $search = (Get-Content $source | Select-Object -First 1).split(' ')[0]
    $check=(choco search $search) | Where-Object {$_ -match $search} | Where-Object {$_ -match 'broken'}
    get-content $source | Select-Object -Skip 1 | set-content "$source-temp"
    Move-Item "$source-temp" $source -Force
    if(($check.Count -gt 0) -or (Test-Path("../automatic/$search"))) {
        $search = ''
    }
}

Install-PackageProvider -name winget -Force
. $PSScriptRoot\..\scripts\New-Githubissue.ps1

if((!(Find-GitHubIssue -Type issue -Repo "$Owner/$Repository" -Labels 'ToCreateManualy' -State open))) {
    if(!(Test-Path "$($PSScriptRoot)/../automatic/$search") -or ($version -ne '')) {
        if($winout = ($(Find-Package $search).Version)) {
            "|$search|" | Add-Content "$($PSScriptRoot)/Check/Todo.md"
            Write-Output "$search v$($winout) available"
            [string]$Label = "ToCreateFrom"
            [string]$Title = "([$($search)$($version)](https://chocolatey.org/packages/$search$($version))) Needs update"
            [string]$Description = "($search) Outdated and needs to be updated"
            if (!(Find-GitHubIssue -Type issue -Repo "$Owner/$Repository" -State open)) {
                New-GithubIssue -Title $Title -Description $Description -Label $Label -owner $Owner -Repository $Repository -Headers $Headers
            }
        } else {
            Write-Output "$search not available on winget"
            "|$search|" | Add-Content "$($PSScriptRoot)/Check/Todo.md"
            Get-Content $source | Select-Object -Skip 1 | set-content "$source-temp"
            Move-Item "$source-temp" $source -Force
            [string]$Label = "ToCreateManualy"
            [string]$Title = "($($search)$($version)) Needs update"
            [string]$Description = "([$search](https://chocolatey.org/packages/$search)) Outdated and needs to be updated"
            if (!(Find-GitHubIssue -Type issue -Repo "$Owner/$Repository" -State open)) {
                New-GithubIssue -Title $Title -Description $Description -Label $Label -owner $Owner -Repository $Repository -Headers $Headers
            }
        }
    } else {
        Write-Output "$search already maintained here or not broken"
        Get-Content $source | Select-Object -Skip 1 | set-content "$source-temp"
        if($search -ne '') {
            Move-Item "$source-temp" $source -Force
        }
    }
    if($search -ne '') {
        git add -u :/tools/Check/
        git commit -m "Package check $search"
        git push origin master
    }
}
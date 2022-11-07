$ErrorActionPreference = 'Continue';
$link=''

# Requisites
Install-Module PowerShellForGitHub -ErrorAction SilentlyContinue
Import-Module PowerShellForGitHub
if(!(Test-Path Env:github_api_key)) {
    $Env:github_api_key   = $Github_personal_token          #Github personal access token
}
[string]$Owner = "tunisiano187"
[string]$Repository = "Chocolatey-packages"

$search = ''
$version = ''

# Check if there is a waiting issue
if(Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -State Open -Label "-Waiting_maintainer_answer") {
    Write-Warning "Some issues are still open"
    Write-Warning "Not checking for broken packages"
    exit 0;
}
# Wait to avoid api requests limit
Start-Sleep 10;

Install-PackageProvider -name winget

# Check if one package is waiting for maintainer action on Chocolatey
if($Todo.Count -eq 0) {
    $chocoprofile = "https://community.chocolatey.org/profiles/tunisiano"
    $links = ((Invoke-WebRequest -Uri $chocoprofile -UseBasicParsing).links | Where-Object {$_.outerHTML -match "maintainer"}).href
    $ToDo=$links
    foreach ($item in $links) {
        $search=$item.split('/')[-2]
        $version=$item.split('/')[-1]
        [string]$Label = "ToCreateManualy"
        [string]$Title = "($($search)/$($version)) Require maintainer action"
        [string]$Description = "([$search](https://community.chocolatey.org/packages/$search/$version)) Waiting for maintainer action"
        if (!(Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -State Open)) {
            New-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -Title $Title -Body $Description -Label $Label
        }
    }
}

# If no package is waiting
# Take a package that is requested on the chocolatey-package-requests
if($Todo.Count -eq 0) {
    $issues = Get-GitHubIssue -OwnerName chocolatey-community -RepositoryName chocolatey-package-requests -State Open -AssigneeType None -Sort Created -Label "Status: Available For Maintainer(s)" | Where-Object {$_.Title -match 'RFM'} | Where-Object {$_.user.login -notmatch 'tunisiano187'}
    foreach ($issue in $issues) {
        $ToDo = $issue.Title.split(' ')[-1]
        if(!(Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository | ? {$_.title -match "($ToDo)"} | ? {$_.created -lt $((Get-Date).AddDays(-90))})) {
            $link = "[$($ToDo)](https://github.com/chocolatey-community/chocolatey-package-requests/issues/$($issue.number))"
            return
        } else {
            $ToDo = ''
        }
    }
}
if((Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository | ? {$_.title -match "($ToDo)"} | ? {$_.created -lt $((Get-Date).AddDays(-90))})) {
    $ToDo=""
    $link=""
}
## If no package is waiting
## Take a package that needs action on the Todo repository (Mostly dtgm packages)
#if($Todo.Count -eq 0) {
#    Invoke-WebRequest -uri https://gitlab.com/chocolatey-packages/todo/-/raw/master/README.md -OutFile "$($env:TEMP)\list.txt"
#    $Todo=$(Get-Content "$($env:TEMP)\list.txt" | Where-Object {$_ -notmatch '#'} | Where-Object {$_ -notmatch 'Count' } | Where-Object {$_ -notmatch '--'} | Select-Object -First 1).split('|')[-2]
#    $ToDo=$ToDo.Trim()
#}

# Clean the search item
$ToDo=$ToDo.trim()
# Check if there is already a closed issue about this request and avoid search
if($ToDo.Count -gt 0){
    $search = $ToDo
    $closed = Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -State Closed | ? {$_.title -match "($ToDo)"} | ? {$_.created -lt $((Get-Date).AddDays(-90))}
    if($closed.Count -gt 0) {
        $search = ''
        $version = ''
    }
}

# if the search var is empty, search in the list.txt file (obtained by seaching for [outdated] term)
if($search -eq '') {
    $source = Join-Path $PSScriptRoot "Check/list.txt"
    $search = (Get-Content $source | Select-Object -First 1).split(' ')[0]
    $check=(choco search $search) | Where-Object {$_ -match $search} | Where-Object {$_ -match 'broken'}
    get-content $source | Select-Object -Skip 1 | set-content "$source-temp"
    Move-Item "$source-temp" $source -Force
    if(($check.Count -gt 0) -or (Test-Path("$($PSScriptRoot)/../automatic/$search"))) {
        $search = ''
        $version = ''
    }
    $link = "From [list.txt](https://raw.githubusercontent.com/tunisiano187/Chocolatey-packages/master/tools/Check/list.txt)"
    git add 
}

if((!(Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -Label "ToCreateManualy" -State Open))) {
    if(!(Test-Path "$($PSScriptRoot)/../automatic/$search") -or ($version -ne '')) {
        if($winout = ($(Find-Package $search).Version)) {
            "|$search|" | Add-Content "$($PSScriptRoot)/Check/Todo.md"
            Write-Output "$search v$($winout) available"
            $link = "$link
$search v$($winout) available on Winget"
            $issue = Get-GitHubIssue -OwnerName chocolatey-community -RepositoryName chocolatey-package-requests -State Open -Sort Created | Where-Object {$_.Title -match $Todo} | Select-Object -First 1
            if($issue) {
                $link = "[$($ToDo)](https://github.com/chocolatey-community/chocolatey-package-requests/issues/$($issue.number))"
            }
            [string]$Label = "ToCreateFrom"
            [string]$Title = "([$($search)$($version)](https://chocolatey.org/packages/$search$($version))) Needs update"
            [string]$Description = "($search) Outdated and needs to be updated
$link"
            if (!(Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -State Open -Label "-Waiting_maintainer_answer")) {
                New-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -Title $Title -Body $Description -Label $Label
            }
        } else {
            Write-Output "$search not available on winget"
            "| $search | " | Add-Content "$($PSScriptRoot)/Check/Todo.md"
            Get-Content $source | Select-Object -Skip 1 | set-content "$source-temp"
            Move-Item "$source-temp" $source -Force
            $issue = Get-GitHubIssue -OwnerName chocolatey-community -RepositoryName chocolatey-package-requests -State Open -AssigneeType None -Sort Created | Where-Object {$_.Title -match $ToDo} | Select-Object -First 1
            if($issue) {
                $link = "[$($ToDo)](https://github.com/chocolatey-community/chocolatey-package-requests/issues/$($issue.number))"
            }
            [string]$Label = "ToCreateManualy"
            [string]$Title = "($($search)$($version)) Needs update"
            [string]$Description = "([$search](https://chocolatey.org/packages/$search)) Outdated and needs to be updated
$link"
            if (!(Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -State Open -Label "-Waiting_maintainer_answer")) {
                New-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -Title $Title -Body $Description -Label $Label
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
if((git commit -m "Package check $search" | Where-Object {$_ -match 'git push'}).count -gt 0) {
    git push origin master
}
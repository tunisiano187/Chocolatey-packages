$ErrorActionPreference = 'SilentlyContinue';
$link=''
$issue = 0
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

# Sort Exclude file
$excludefile = '.\tools\Check\exclude.txt'
Get-Content $excludefile | Sort-Object | Select-Object -Unique | Set-Content $excludefile

"Check if there are open issues"
# Check if there is a waiting issue
if((Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -State Open | Where-Object {$_.labels.name -notmatch "Waiting_maintainer_answer"})) {
    Write-Warning "Some issues are still open"
    Write-Warning "Not checking for broken packages"
} else {

    # Check if one package is waiting for maintainer action on Chocolatey
    if($Todo.Count -eq 0) {
        "Checking on Chocolatey community profile"
        $chocoprofile = "https://community.chocolatey.org/profiles/tunisiano"
        $links = ((Invoke-WebRequest -Uri $chocoprofile -UseBasicParsing).links | Where-Object {$_.outerHTML -match "maintainer"} | Where-Object {$_.outerHTML -notmatch "capture2text"} | Where-Object {$_.outerHTML -notmatch "winedt"} | Where-Object {$_.outerHTML -notmatch "thebrain.install"} | Where-Object {$_.outerHTML -notmatch "gdevelop"}).href
        $ToDo=$links
        foreach ($item in $links) {
            $search=$item.split('/')[-2]
            $version=$item.split('/')[-1]
            [string]$Label = "ToCreateManualy"
            [string]$Title = "($($search)/$($version)) Require maintainer action"
            [string]$Description = "([$search](https://community.chocolatey.org/packages/$search/$version)) Waiting for maintainer action"
            if (!(Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -State Open)) {
                "Create issue for $search"
                New-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -Title $Title -Body $Description
                $issue=1
                exit 0
            }
        }
    }

    # If no package is waiting
    # Take a package that is requested on the chocolatey-package-requests
    if($Todo.Count -eq 0 -and $issue -eq 0) {
        "Checking on the chocolatey-package-requests"
        $issues = Get-GitHubIssue -OwnerName chocolatey-community -RepositoryName chocolatey-package-requests -State Open -AssigneeType None -Sort Created -Label "Status: Available For Maintainer(s)" | Where-Object {$_.Title -match 'RFM'} | Where-Object {$_.Title -notmatch 'Oculus'} | Where-Object {$_.user.login -notmatch 'tunisiano187'} | Sort-Object "IssueNumber"
        foreach ($issue in $issues) {
            $search = $issue.Title.split(' ')[-1]
            "Checking $search"
            if(!((Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository | Where-Object {$_.title -match "($search)"} | Where-Object {$_.created -lt $((Get-Date).AddDays(-90))})) -and (!((Get-Content .\tools\Check\exclude.txt | Select-String -Pattern $search).Matches.Success)) -AND (!(Test-Path "automatic/$search"))) {
                $link = "[$($search)](https://github.com/chocolatey-community/chocolatey-package-requests/issues/$($issue.number))"
                $link
                if (!(Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -State Open -Label "-Waiting_maintainer_answer")) {
                    [string]$Label = "ToCreateManualy"
                    [string]$Title = "($($search)$($version)) update requested"
                    [string]$Description = "([$search](https://chocolatey.org/packages/$search)) Outdated and needs to be updated
    $link"
                    New-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -Title $Title -Body $Description -Label $Label
                    $issue=1
                    exit 0
                } else {
                    "$search already worked on in the last 90 days"
                    $search = ""
                    $ToDo = ''
                }
            }
        }
    }


    # Clean the search item
    $ToDo=$ToDo.trim()
    # Check if there is already a closed issue about this request and avoid search
    if($ToDo.Count -gt 0 -and $issue -eq 0){
        $search = $ToDo
        $closed = Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -State Closed | Where-Object {$_.title -match "($ToDo)"} | Where-Object {$_.created -lt $((Get-Date).AddDays(-90))}
        if($closed.Count -gt 0) {
            $search = ''
            $version = ''
        }
    }

    # if the search var is empty, search on the needs_new_maintainer profile
    if(!(Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -State Open)) {
        $chocoprofile = $link = "https://community.chocolatey.org/profiles/needs_new_maintainer"
        $links = ((Invoke-WebRequest -Uri $chocoprofile -UseBasicParsing).links | Where-Object {$_.outerHTML -notmatch "Deprecated"} | Where-Object {$_.outerHTML -notmatch "Retired"} | Where-Object {$_.href -match '/packages/'}).href
        $ToDo=$links
        foreach ($item in $links) {
            $search=$item.split('/')[-1]
            [string]$Label = "ToCreateManualy"
            [string]$Title = "($($search)) update requested"
            [string]$Description = "([$search](https://chocolatey.org/packages/$search)) Outdated and needs to be updated
            $link"
            if (!(Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -State Open)) {
                "Create issue for $search"
                New-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -Title $Title -Body $Description
                $issue=1
                exit 0
            }
        }
    }

    # if the search var is empty, search in the list.txt file (obtained by seaching for [outdated] term)
    if(!(Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -State Open)) {
        "Checking list.txt file"
        $source = Join-Path $PSScriptRoot "Check/list.txt"
        $search = (Get-Content $source | Select-Object -First 1).split(' ')[0]
        $check=(choco search $search) | Where-Object {$_ -match $search} | Where-Object {$_ -match 'broken'}
        get-content $source | Select-Object -Skip 1 | set-content "$source-temp"
        Move-Item "$source-temp" $source -Force
        git add -u
        git commit -m "remove first line
[skip ci]"
        git push
        if(($check.Count -eq 0) -or (Test-Path("$($PSScriptRoot)/../automatic/$search"))) {
            $search = ''
            $version = ''
        }
        $link = "From [list.txt](https://raw.githubusercontent.com/tunisiano187/Chocolatey-packages/master/tools/Check/list.txt)"
        if (!(Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -State Open -Label "-Waiting_maintainer_answer" | Where-Object {$_ -notmatch "Set-GitHubConfiguration"}) -and $search -ne '') {
            [string]$Label = "ToCreateManualy"
            [string]$Title = "($($search)$($version)) update requested"
            [string]$Description = "([$search](https://chocolatey.org/packages/$search)) Outdated and needs to be updated
$link"
            New-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -Title $Title -Body $Description -Label $Label
            $issue=1
            exit 0
        } else {
            "$search already worked on in the last 90 day"
            $search = ""
            $ToDo = ''
        }
    }

    if(!(Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -State Open)) {
        "Checking For RFP on the chocolatey-package-requests git"
        $issues = Get-GitHubIssue -OwnerName chocolatey-community -RepositoryName chocolatey-package-requests -State Open -AssigneeType None -Sort Created -Label "Status: Available For Maintainer(s)" | Where-Object {$_.Title -match 'RFP'} | Where-Object {$_.user.login -notmatch 'tunisiano187'} | Sort-Object "IssueNumber"
        foreach ($issue in $issues) {
            $search = ($issue.Title.split('-')[-1]).trim().replace(" ","-")
            "Checking $search"
            if(!((Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository | Where-Object {$_.title -match "($search)"} | Where-Object {$_.created -lt $((Get-Date).AddDays(-90))})) -and (!((Get-Content .\tools\Check\exclude.txt | Select-String -Pattern $search).Matches.Success)) -AND (!(Test-Path "automatic/$search"))) {
                $link = "[$($search)](https://github.com/chocolatey-community/chocolatey-package-requests/issues/$($issue.number))"
                $link
                if (!(Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -State Open -Label "-Waiting_maintainer_answer")) {
                    [string]$Label = "ToCreateManualy"
                    [string]$Title = "($($search)$($version)) package requested"
                    [string]$Description = "([$search](https://chocolatey.org/packages/$search)) Outdated and needs to be updated
    $link"
                    New-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -Title $Title -Body $Description -Label $Label
                    $issue=1
                    exit 0
                } else {
                    "$search already worked on in the last 90 day"
                    $search = ""
                    $ToDo = ''
                }
            }
        }
    }

    "Comparing to winget"
    if($issue -eq 0 -and (!(Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -Label "ToCreateManualy" -State Open))) {
        Install-PackageProvider -Name winget
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
                    $issue=1
                }
            } elseif ($issue -eq 0) {
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
                    $issue=1
                }
            }
        } else {
            Write-Output "$search already maintained here or not broken"
            Get-Content $source | Select-Object -Skip 1 | set-content "$source-temp"
            if($search -ne '') {
                Move-Item "$source-temp" $source -Force
            }
        }
    }
    git add -u
    if((git commit -m "Package check $search" | Where-Object {$_ -match 'git push'}).count -gt 0) {
        git push origin master
    }
}
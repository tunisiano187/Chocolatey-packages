$ErrorActionPreference = 'Continue';

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

if(Find-GitHubIssue -Type issue -Repo "$Owner/$Repository" -State open){
    Write-Warning "Some issues are still open"
    Write-Warning "Not checking for broken packages"
    exit 0;
}

$ToDo = Find-GitHubIssue -Type issue -Repo "chocolatey-community/chocolatey-package-requests" -State open -No assignee -SortBy updated | Where-Object {$_.Labels -match 'maint'} | Where-Object {$_.Title -match 'RFM'} | Select-Object -First 1
if($ToDo){
    $search = $ToDo.Title.split(' ')[-1]
} else {
    $source = Join-Path $PSScriptRoot "Check/list.txt"
    $search = (Get-Content $source | Select-Object -First 1).split(' ')[0]
}

Install-PackageProvider -name winget -Force
. $PSScriptRoot\..\scripts\New-Githubissue.ps1

if((!(Find-GitHubIssue -Type issue -Repo "$Owner/$Repository" -Labels 'ToCreateManualy' -State open))) {
    if(!(Test-Path "$($PSScriptRoot)/../automatic/$search")) {
        if($winout = ($(Find-Package $search).Version)) {
            "|$search|" | Add-Content "$($PSScriptRoot)/Check/Todo.md"
            Write-Output "$search v$($winout) available"
            [string]$Label = "ToCreateFrom"
            [string]$Title = "([$search](https://chocolatey.org/packages/$search)) Needs update"
            [string]$Description = "($search) Outdated and needs to be updated"
            if(!(Find-GitHubIssue -Type issue -Repo "$Owner/$Repository" -State open)) {
                New-GithubIssue -Title $Title -Description $Description -Label $Label -owner $Owner -Repository $Repository -Headers $Headers
            }
        } else {
            Write-Output "$search not available on winget"
            "|$search|" | Add-Content "$($PSScriptRoot)/Check/Todo.md"
            Get-Content $source | Select-Object -Skip 1 | set-content "$source-temp"
            Move-Item "$source-temp" $source -Force
            [string]$Label = "ToCreateManualy"
            [string]$Title = "($search) Needs update"
            [string]$Description = "([$search](https://chocolatey.org/packages/$search)) Outdated and needs to be updated"
            if(!(Find-GitHubIssue -Type issue -Repo "$Owner/$Repository" -State open)) {
                New-GithubIssue -Title $Title -Description $Description -Label $Label -owner $Owner -Repository $Repository -Headers $Headers
            }
        }
    } else {
        Write-Output "$search already maintained here"
        Get-Content $source | Select-Object -Skip 1 | set-content "$source-temp"
        Move-Item "$source-temp" $source -Force
    }
    git add -u :/tools/Check/
    git commit -m "Package check $search"
    git push origin master
}
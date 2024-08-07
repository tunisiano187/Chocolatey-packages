$ErrorActionPreference = 'SilentlyContinue'
Install-Module psgithubsearch -ErrorAction SilentlyContinue
Import-Module psgithubsearch
if(!(Test-Path Env:github_api_key)) {
    $Env:github_api_key   = $Github_personal_token          #Github personal access token
}
[string]$Owner = "tunisiano187"
[string]$Repository = "Chocolatey-packages"

Write-Output "Search the next package to import"
$search = (Get-GitHubIssue -OwnerName $Owner -RepositoryName $Repository -State Open -Label "ToCreateManualy" | Sort-Object -Property IssueNumber).Title.split('(|)')[1]
if($search -and $packageName -match "update requested") {
    $folder = Join-Path $PSScriptRoot "../automatic/$search"
    if(Test-Path $folder) {
        Write-Warning "Package already in the folder, the package $search needs to be finished and the issue closed"
    } elseif ($search -ne '') {
        $script = Join-Path $PSScriptRoot "Get-Package.ps1"
        "Running $($script) $($search.Tolower())"
        . $script $search.Tolower()
    }
} elseif($search -and $packageName -match "package requested") {
    if(Test-Path $folder) {
        Write-Warning "Package already in the folder, the package $search needs to be finished and the issue closed"
    } elseif ($search -ne '') {
        $script = Join-Path $PSScriptRoot "New-Package.ps1"
        "Running $($script) $($search.Tolower())"
        . $script $search.Tolower()
    }
}

try {
    git push origin master
}
catch {
    "Nothing to push!"
}

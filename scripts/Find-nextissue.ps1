Install-Module psgithubsearch -ErrorAction SilentlyContinue
Import-Module psgithubsearch
if(!(Test-Path Env:github_api_key)) {
    $Env:github_api_key   = $Github_personal_token          #Github personal access token
}
[string]$Owner = "tunisiano187"
[string]$Repository = "Chocolatey-packages"
$UserToken = $env:github_api_key

Write-Output "Search the next package to import"
$search = (Find-GitHubIssue -Type issue -Repo "$Owner/$Repository" -State open -Labels "ToCreateManualy" | Sort-Object -Property Number).Title.split('(|)')[1]
$folder = Join-Path $PSScriptRoot "../automatic/$search"
if(Test-Path $folder) {
    Write-Warning "Package already in the folder, the package $search needs to be finished and the issue closed"
} else {
    $script = Join-Path $PSScriptRoot "Get-Package.ps1"
    . $script $search
    git add :/automatic/$search/
    git commit -m "Package $search downloaded"
    git push
}
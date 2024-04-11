$ErrorActionPreference = 'Continue'
param(
    [Parameter(Mandatory = $true)]
    [string]$packageName
)

Install-Module psgithubsearch -ErrorAction SilentlyContinue
Import-Module psgithubsearch

[string]$Owner = "tunisiano187"
[string]$Repository = "Chocolatey-packages"

Write-Output "Search the next package to import"
$search = $packageName
if($search) {
    $folder = Join-Path $PSScriptRoot "../automatic/$search"
    if(Test-Path $folder) {
        Write-Warning "Package already in the folder, the package $search needs to be finished and the issue closed"
    } elseif ($search -ne '') {
        $script = Join-Path $PSScriptRoot "Get-Package.ps1"
        . $script $search.Tolower()
    }
}

try {
    git push origin master
}
catch {
    "Nothing to push!"
}

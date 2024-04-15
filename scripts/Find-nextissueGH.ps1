function Find-nextissueGH {
    param(
        [Parameter(Mandatory = $true)]
        [string]$packageName,
        [Parameter(Mandatory = $true)]
        [string]$actor
    )

    #$ErrorActionPreference = 'Stop'
    Install-Module psgithubsearch -ErrorAction SilentlyContinue -Force
    Import-Module psgithubsearch

    "packageName : $packageName"
    $search = $packageName -split '\(|\)' | Select-Object -Index 1
    "Package to import : $search"

    if($actor -ne 'tunisiano187' -or $packageName -notmatch 'update requested') {
        "Not running the get-package script"
        $search = $null
    }

    if($search) {
        $folder = Join-Path $PSScriptRoot "../automatic/$search"
        if(Test-Path $folder) {
            Write-Warning "Package already in the folder, the package $search needs to be finished and the issue closed"
        } elseif ($search -ne '') {
            $script = Join-Path $PSScriptRoot "Get-Package.ps1"
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
}
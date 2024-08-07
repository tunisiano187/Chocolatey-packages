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
    Write-output $PSVersionTable

    "packageName : $packageName"
    if($packageName -match "exclude") {
        $search = $packageName.substring(6).Split('(')[1].split(')')[0]
    } else {
        $search = $packageName.Split('(')[1].split(')')[0]
    }
    "Package to import : $search"
    if($actor -ne 'tunisiano187') {
        exit 0
    }
    if($packageName -notmatch 'update requested' -and $packageName -notmatch "package requested") {
        "Not running the get-package script"
        $search = $null
        exit 0
    }

    $folder = Join-Path $PSScriptRoot "../automatic/$search"
    $excludefile = Join-Path $PSScriptRoot "../tools/Check/exclude.txt"
    "Checking $excludefile"
    if($search -and $packageName -match "update requested") {
        if(Test-Path $folder) {
            Write-Warning "Package already in the folder, the package $search needs to be finished and the issue closed"
        } elseif ($search -ne '' -and (!((Get-Content $excludefile | Select-String -Pattern $search).Matches.Success))) {
            $script = Join-Path $PSScriptRoot "Get-Package.ps1"
            "Running $($script) $($search.Tolower())"
            . $script "$($search.Tolower())"
        }
    } elseif($search -and $packageName -match "package requested") {
        if(Test-Path $folder) {
            Write-Warning "Package already in the folder, the package $search needs to be finished and the issue closed"
        } elseif ($search -ne '' -and (!((Get-Content $excludefile | Select-String -Pattern $search).Matches.Success))) {
            $script = Join-Path $PSScriptRoot "New-Package.ps1"
            "Running $($script) $($search.Tolower())"
            . $script "$($search.Tolower())"
        }
    }

    try {
        git push origin master
    }
    catch {
        "Nothing to push!"
    }
}
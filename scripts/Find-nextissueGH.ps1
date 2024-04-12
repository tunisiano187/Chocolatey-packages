function Find-nextissueGH {
    param(
        [Parameter(Mandatory = $true)]
        [string]$packageName,
        [Parameter(Mandatory = $true)]
        [string]$actor
    )

    if($actor -ne 'tunisiano187' -or $packageName -notmatch 'update requested') {
        throw "User $actor cannot run this"
    }
    $ErrorActionPreference = 'Continue'
    Install-Module psgithubsearch -ErrorAction SilentlyContinue -Force
    Import-Module psgithubsearch

    Write-Output "Search the next package to import"
    $search = $packageName
    if($search) {
        $folder = Join-Path $PSScriptRoot "../automatic/$search"
        if(Test-Path $folder) {
            Write-Warning "Package already in the folder, the package $search needs to be finished and the issue closed"
        } elseif ($search -ne '') {
            $script = Join-Path $PSScriptRoot "Get-Package.ps1"
            $search
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
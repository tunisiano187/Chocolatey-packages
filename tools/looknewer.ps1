$ErrorActionPreference = 'Continue';
$source = Join-Path $PSScriptRoot "Check/list.txt"
Install-PackageProvider -name winget -Force
. $PSScriptRoot\..\scripts\New-Githubissue.ps1
if(!(Test-Path Env:github_api_key)) {
    $Env:github_api_key   = $Github_personal_token          #Github personal access token
}
[string]$Owner = "tunisiano187"
[string]$Repository = "Chocolatey-packages"
$UserToken = $env:github_api_key
$Headers = @{
    Authorization='token '+$UserToken
}

if((Test-Path $source)) {
    $search = (Get-Content $source | Select-Object -First 1).split(' ')[0]
    if(!(Test-Path "$($PSScriptRoot)/../automatic/$search")) {
        if($winout = ($(Find-Package $search).Version)) {
            Write-Host "$search v$($winout) available"
            [string]$Label = "ToCreateFrom"
            [string]$Title = "($search) Needs update"
            [string]$Description = "($search) Outdated and needs to be updated"
            New-GithubIssue -Title $Title -Description $Description -Label $Label -owner $Owner -Repository $Repository -Headers $Headers
        } else {
            Write-host "$search not available on winget"
            Get-Content $source | Add-Content "$($PSScriptRoot)/Check/Todo.txt"
            Get-Content $source | Select-Object -Skip 1 | set-content "$source-temp"
            Move-Item "$source-temp" $source -Force
            [string]$Label = "ToCreateManualy"
            [string]$Title = "($search) Needs update"
            [string]$Description = "($search) Outdated and needs to be updated"
            New-GithubIssue -Title $Title -Description $Description -Label $Label -owner $Owner -Repository $Repository -Headers $Headers
        }
    } else {
        Write-host "$search already maintained here"
        Get-Content $source | Select-Object -Skip 1 | set-content "$source-temp"
        Move-Item "$source-temp" $source -Force
    }
    git add "$($PSScriptRoot)/Check/*.txt"
    git commit -m "[skip-ci] Package check $search"
}
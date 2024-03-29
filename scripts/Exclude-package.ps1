<#
.SYNOPSIS
  Remove Package from folder

.DESCRIPTION
  This script should be called by Github action on Issue editing to remove a package.

#>
function Exclude-Package {
    param(
        [Parameter(Mandatory = $true, ParameterSetName = "issue")]
        [long]$issueNumber,
        [Parameter(Mandatory = $true)]
        [string]$title,
        [Parameter(Mandatory = $false)]
        [string]$Repository
    )

    Write-Output "Repository : $Repository"

    Install-Module psgithubsearch -ErrorAction SilentlyContinue
    Import-Module psgithubsearch
    if(!(Test-Path Env:github_api_key)) {
        $Env:github_api_key   = $Github_personal_token          #Github personal access token
    }
    [string]$Owner = "tunisiano187"
    [string]$Repository = "Chocolatey-packages"

    Write-Output "number : $issueNumber"
    Write-Output "Title : $title"
    $extract = $title.Split('(')[1].split(')')[0]
    Write-Output "Extract : $extract"
    $folder = Join-Path $PSScriptRoot "../automatic/$extract"
    Write-Output "Does the Folder exists ? : $(Test-Path -Path $folder)"
    if(!$title.ToLower -match "exclude") {
      Write-Output "Not an Exclude request"
    } else {
      if($(Test-Path -Path $folder)) {
        Remove-Item -Path $folder -Recurse -Force -ErrorAction Continue
        Remove-Item -Path "../icons/$extract.*" -ErrorAction Continue
      }
      Update-GitHubIssue -OwnerName $Owner -RepositoryName $repository -Issue $issueNumber -State Closed
    }
}

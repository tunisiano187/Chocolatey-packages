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
        [string]$repository
    )
    Write-Output "number : $issueNumber"
    Write-Output "Repository : $repository"
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
      Update-GitHubIssue -OwnerName tunisiano187 -RepositoryName chocolatey-packages -Issue $issueNumber -State Closed
    }
}

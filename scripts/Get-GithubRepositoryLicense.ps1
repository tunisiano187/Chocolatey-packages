<#
.SYNOPSIS
  Get the License informations from GitHub

.DESCRIPTION
  This script should be called in au_BeforeUpdate to get the informations to download

.PARAMETER repoUser
  Name of the repository owner.

.PARAMETER repoName
  Name of the repository.

#>
function Get-GithubRepositoryLicense {
  param (
    [string]$repoUser,
    [string]$repoName
  )
  $headers = @{}

  if (Test-Path Env:\github_api_key) {
    $headers.Authorization = "token " + $env:github_api_key
  }

  $licenseData = Invoke-RestMethod -Uri "https://api.github.com/repos/${repoUser}/${repoName}/license"

  return $licenseData
}

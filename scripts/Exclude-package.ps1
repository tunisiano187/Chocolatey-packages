<#
.SYNOPSIS
  Updates nuspec file description from README.md

.DESCRIPTION
  This script should be called in au_AfterUpdate to put the text in the README.md
  into description tag of the Nuspec file. The current description will be replaced.
  Function will throw an error if README.md is not found.

.PARAMETER SkipFirst
  Number of start lines to skip from the README.md, by default 0.

.PARAMETER SkipLast
  Number of end lines to skip from the README.md, by default 0.

.EXAMPLE
  function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2 }
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
    Write-Host "number : $issueNumber"
    Write-Host "Title : $title"
    $extract = $($title.split('(|)')[1])
    Write-Host "Extract : $extract"
    $folder = Join-Path $PSScriptRoot "../automatic/$extract"
    Write-Host "Test : $(Test-Path -Path $folder)"
}

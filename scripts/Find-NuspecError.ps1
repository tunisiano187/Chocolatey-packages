<#
.SYNOPSIS
    Check the content of the nuspec for common errror and output them

.DESCRIPTION
    Check the nuspec for missing fields, incorrect characters, ... and output them

.PARAMETER folder
    The folder where the packages are

.OUTPUTS
    The errors or OK
#>
function Find-NuspecError {
    param(
        [string]$folder = '../automatic/'
    )

    $folder = "$PSScriptRoot/$($folder)"
    $nuspecs = Get-ChildItem -Path $folder -Filter *.nuspec -Recurse
    $errors = ''

    foreach ($nuspec in $nuspecs) {
        [xml]$content = Get-Content $nuspec.FullName
        If(!($content.package.files)) {
            throw "$($nuspec.Name): missing <files></files>"
        }

        If(!($content.package.metadata.packageSourceUrl)) {
            throw "$($nuspec.Name): missing <packageSourceUrl></packageSourceUrl>"
        }
    }
}

Find-NuspecError
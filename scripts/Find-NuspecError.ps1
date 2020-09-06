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
        [string]$folder = "../automatic/"
    )

    $folder = "$PSScriptRoot/$($folder)"
    $nuspecs = Get-ChildItem -Path $folder -Filter *.nupkg -Recurse
    $errors = ''

    foreach ($nuspec in $nuspecs) {
        $errornuspec = ''
        $content = Get-Content $nuspec.FullName
        $contain = $content | ForEach-Object{$_ -match '<files'}
        If($contain -contains $false) {
            $errornuspec = "$errornuspec $($nuspec.Name): missing <files></files>`n"
        }

        if($errornuspec -ne '') {
            $errors = "$errornuspec `n"
        }
    }
    if($errors -eq '') {
        return "OK"
    } else {
        return $errors
    }
}

Find-NuspecError
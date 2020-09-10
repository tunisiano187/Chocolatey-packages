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
    $nuspecs = Get-ChildItem -Path $folder -Filter *.nuspec -Recurse
    $errors = ''

    foreach ($nuspec in $nuspecs) {
        $errornuspec = ''
        $content = Get-Content $nuspec.FullName
        $contain = $content | ForEach-Object{$_ -notmatch '<files'}
        If($contain -contains $true) {
            $errornuspec = "$errornuspec $($nuspec.Name): missing <files></files> `n "
        }

        $contain = $content | ForEach-Object{$_ -notmatch '<packageSourceUrl>'}
        If($contain -contains $true) {
            $errornuspec = "$errornuspec $($nuspec.Name): missing <packageSourceUrl></packageSourceUrl>`n "
        }

        if($errornuspec.count -ne 0) {
            $errors = "$errornuspec `n "
        }
    }
    if($errors.count -eq 0) {
        return "OK"
    } else {
        throw $errors
        #return $errors
    }
}

Find-NuspecError
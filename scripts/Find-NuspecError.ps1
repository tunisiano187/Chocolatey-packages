<#
.SYNOPSIS
    Check the content of the nuspec for common errror and output them

.DESCRIPTION
    Check the nuspec for missing fields, incorrect characters, ... and output them

.PARAMETER folder
    The folder Where-Object the packages are

.OUTPUTS
    The errors or OK
#>
function Find-NuspecError {
    param(
        [string]$folder = '../automatic/'
    )

    $folder = "$PSScriptRoot/$($folder)"

    # Update to the latest official xml
    choco new test --outputdirectory $env:TEMP\Chocolatey\
    $nuspecofficel = Get-Content -Path "$env:TEMP\Chocolatey\test\test.nuspec"
    $nuspecstart = $nuspecofficel.Where({$_ -match "<metadata>"},'until') | Where-Object {$_ -notmatch "^\s*#"} | ForEach-Object {$_ -replace '(^.*?)\s*?[^``]#.*','$1'} | ForEach-Object {
        if(($_ -notmatch '\*') -and (($_ -match '<package') -or ($_ -match 'Ω') -or ($_ -match '<?xml')))
        {
            $_
        }
    }

    $nuspecs = Get-ChildItem -Path $folder -Filter *.nuspec -Recurse

    foreach ($nuspec in $nuspecs) {
        [xml]$content = Get-Content $nuspec.FullName
        $filecontent = Get-Content $nuspec.FullName

        # Get the latest official xml informations
        $nuspecend = $filecontent.Where({$_ -match "<metadata>"},'skipuntil') | Select-Object -Skip 1
        $filecontent = "$nuspecstart
$nuspecend"

        # Check if the files section exists to avoid embedding useless files
        If(!($filecontent -match 'files')) {
            $errormsg = ': missing <files><file src="tools\**" target="tools" /></files>'
            throw "$($nuspec.Name) $($errormsg)"
        }

        # Check if the packageSourceURL section exists
        If(!($filecontent -match 'packageSourceUrl')) {
            throw "$($nuspec.Name): missing <packageSourceUrl></packageSourceUrl>"
        }

        # check if the description contains French words
        If($content.package.metadata.description -match " est ") {
            throw "$($nuspec.Name): Description in French should be in english"
        }

    }
}

Find-NuspecError

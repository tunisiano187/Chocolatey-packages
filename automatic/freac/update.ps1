$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://api.github.com/repos/enzo1982/freac/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2


function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).portable`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
    }
}

function global:au_GetLatest {
    $choc=$(choco search freac.portable | Where-Object {$_ -match "freac.portable"})
	$version = $choc.Split(" ")[1]

    return @{
        Version = $version
    }
}

update-package -CheckSumFor none

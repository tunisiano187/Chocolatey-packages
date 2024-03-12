$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/nteract/nteract/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
    @{
         "$($Latest.PackageName).nuspec" = @{
             "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
         }
     }
 }

function global:au_GetLatest {
    $choc=$(choco search nteract.install | Where-Object {$_ -match "nteract.install"})
	$version = $choc.Split(" ")[1]

    return @{
        Version = $version
    }
}

update-package -ChecksumFor 32 -NoCheckUrl
$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://github.com/dogecoin/dogecoin/releases/latest"
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
    $choc=$(choco search dogecoin.install | Where-Object {$_ -match "dogecoin.install"})
	$version = $choc.Split(" ")[1]
    Update-Metadata -key "releaseNotes" -value $tags.html_url
	
    return @{
        Version = $version
    }
}

update -ChecksumFor none

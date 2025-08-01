$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://cdist2.perforce.com/perforce/'

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"p4merge`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
	}
}

function global:au_GetLatest {
	$choc=$(choco search p4merge | Where-Object {$_ -match "p4merge"})
	$version = $choc.Split(" ")[1]

	$url64 = "https://cdist2.perforce.com/perforce/r$($version)/bin.ntx64/p4vinst64.exe"

	$Latest = @{ URL32 = $url64; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckUrl

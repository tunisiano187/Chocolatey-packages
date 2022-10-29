$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://cdist2.perforce.com/perforce/'

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"p4merge`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
	}
}

function global:au_GetLatest {
	Write-Output 'Check Folder'
	$version=$(choco search ^p4merge$ | Where-Object {$_ -notmatch 'found.'} | Where-Object {$_ -notmatch 'Did you know'} | Where-Object {$_ -notmatch 'Chocolatey v'} | Where-Object {$_ -notmatch "NuGet"} | Select-Object -First 1).split(' ')[1]

	$license = "https://cdist2.perforce.com/perforce/r$($version.Substring(2))/doc/user/p4v_license.txt"
	$url64 = "https://cdist2.perforce.com/perforce/r$($version.Substring(2))/bin.ntx64/p4vinst64.exe"

	$Latest = @{ URL32 = $url64; Version = $version; License = $license }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
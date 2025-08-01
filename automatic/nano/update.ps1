import-module chocolatey-AU


function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"nano-win`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
	}
}


function global:au_GetLatest {
	$version = $((choco search nano-win -s https://community.chocolatey.org/api/v2) | Where-Object {$_ -match "nano-win"}).split(' ') | Where-Object {$_ -match "\."}


	$Latest = @{ Version = $version }
	return $Latest
}

update -NoCheckChocoVersion -ChecksumFor none

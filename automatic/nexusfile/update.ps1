import-module chocolatey-AU


function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
	}
}


function global:au_GetLatest {
	$version = $((choco search nexusfile.install -s https://community.chocolatey.org/api/v2) | Where-Object {$_ -match "nexusfile.install"}).split(' ') | Where-Object {$_ -match "\.[0-9]"}


	$Latest = @{ Version = $version }
	return $Latest
}

update -ChecksumFor none

import-module chocolatey-AU

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
			 "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
		 }
	}
}

function global:au_GetLatest {
	$choc=$(choco search thebrain.install | Where-Object {$_ -match "thebrain.install"})
	$version = $choc.Split(" ")[1]

    return @{
        Version = $version
    }
}

update -ChecksumFor none -NoCheckChocoVersion

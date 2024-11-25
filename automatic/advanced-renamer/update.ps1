import-module au

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"$($Latest.Version)`""
        }
	}
}

function global:au_GetLatest {
	$choc=$(choco search advanced-renamer | Where-Object {$_ -match "advanced-renamer"})
	$version = $choc.Split(" ")[1]

    return @{
        Version = $version
    }
}

Update-Package -ChecksumFor none
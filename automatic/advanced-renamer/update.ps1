import-module chocolatey-AU

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"$($Latest.Version)`""
        }
	}
}

function global:au_GetLatest {
	$choc=$(choco search advanced-renamer.install | Where-Object {$_ -match "advanced-renamer.install"})
	$version = $choc.Split(" ")[1]
    if($version -eq "3.94.3") {
        $version = "3.94.3.2024112501"
    }

    return @{
        Version = $version
    }
}

Update-Package -ChecksumFor none

import-module chocolatey-AU

$releases = 'http://sourceforge.net/projects/projectlibre/files/latest/download'

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
			 "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
		 }
	}
}

function global:au_GetLatest {
	$choc=$(choco search projectlibre.install | Where-Object {$_ -match "projectlibre.install"})
	$version = $choc.Split(" ")[1]

    return @{
        Version = $version
    }
}

update -ChecksumFor none

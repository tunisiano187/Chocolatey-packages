import-module au

$releases = 'http://sourceforge.net/projects/projectlibre/files/latest/download'

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
			 "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
		 }
	}
}

function global:au_GetLatest {
	$url32 = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '.exe'}).href | Select-Object -First 1
	$version = $url32.Split('/')[-2]

	$url32 = "https://netix.dl.sourceforge.net/project/projectlibre/ProjectLibre/$version/projectlibre-$version.exe"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none

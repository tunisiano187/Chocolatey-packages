$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/jonelo/jacksum-fbi-windows/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
		"$($Latest.PackageName).nuspec" = @{
			"(\<releaseNotes\>).*?(\</releaseNotes\>)" 	= "`${1}$($Latest.ReleaseNotes)`$2"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo
	$url32 = $tags.assets.browser_download_url | Where-Object {$_ -match ".zip$"} | select-object -First 1
	$version = $tags[0].tag_name -split 'v|/' | select-object -Last 1
	$releaseNotes="https://github.com/$($Owner)/$($repo)/releases/tag/$($tags[0].tag_name)"
	if($tags[0].prerelease -match "true") {
		$date = $tags[0].published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}

	$Latest = @{ URL32 = $url32; Version = $version; ReleaseNotes = $releaseNotes }
	return $Latest
}

update
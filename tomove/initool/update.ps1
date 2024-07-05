$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/dbohdan/initool/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"      	= "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
		"$($Latest.PackageName).nuspec" = @{
			"(\<releaseNotes\>).*?(\</releaseNotes\>)"		= "`${1}$($Latest.ReleaseNotes)`$2"
			"(\<copyright\>).*?(\</copyright\>)" 	= "`${1} © $((Get-Date).year) D. Bohdan`$2"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$urls = $tags.assets.browser_download_url | Where-Object {$_ -match ".zip$"}
	$url32 = $urls | Where-Object {$_ -match 'win32'}
	$version = ($url32 -split '-' | Where-Object {$_ -match '^v'}).replace('v','')
	if($tags.prerelease -match "true") {
		$date = $tags.published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}
	$releaseNotes="[Changelog](https://github.com/$($Owner)/$($repo)/releases/tag/$($tags[0].tag_name))"

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version; ReleaseNotes = $releaseNotes }
	return $Latest
}

update -NoCheckUrl -ChecksumFor 32
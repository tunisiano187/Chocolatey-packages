$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/mesonbuild/meson/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url64\s*=\s*)('.*')"      			= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 			= "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumtype64\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType64)'"
		}
		"$($Latest.PackageName).nuspec" = @{
			"(\<releaseNotes\>).*?(\</releaseNotes\>)"		= "`${1}$($Latest.ReleaseNotes)`$2"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$url64 = $tags.assets.browser_download_url | Where-Object {$_ -match ".msi$"}
	$version = $tags.tag_name.Replace('v','')
	if($tags.prerelease -match "true") {
		$date = $tags.published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}

	$releaseNotes="https://github.com/$($Owner)/$($repo)/releases/tag/$($tags[0].tag_name)"

	$Latest = @{ URL64 = $url64; Version = $version; ReleaseNotes = $releaseNotes }
	return $Latest
}

update -ChecksumFor 64

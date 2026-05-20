import-module chocolatey-AU

$releases = 'https://github.com/Automattic/wp-calypso/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2


function global:au_SearchReplace {
	@{
		'tools/chocolateyinstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$urls = $tags.assets.browser_download_url | Where-Object {$_ -match "\.exe$"}
	$url32 = $urls | Where-Object {$_ -match 'win32'} | Select-Object -First 1
	if (-not $url32) {
		$url32 = $urls | Select-Object -First 1
	}
	if (-not $url32) {
		throw "Could not find Windows exe asset in $Owner/$repo release $($tags.tag_name)"
	}
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	$version = $tags.tag_name.Replace('v','').Replace('-','.')
	if($tags.prerelease -match "true") {
		$date = $tags.published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}

	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = ''; ChecksumType32 = 'sha256' }
	return $Latest
}

update -NoCheckChocoVersion

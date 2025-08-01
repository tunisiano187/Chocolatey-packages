$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

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
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo | select-object -First 1
	$url32 = $tags.assets.browser_download_url | Where-Object {$_ -match ".zip$"} | select-object -First 1
	$version = ($tags.tag_name -split 'v|/' | Where-Object { $_ -match "."}).Trim()
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	if($tags[0].prerelease -match "true") {
		$date = $tags[0].published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion

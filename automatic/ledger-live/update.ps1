import-module au

$releases = 'https://github.com/LedgerHQ/ledger-live/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2


function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	# Get latest version from Gihub
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo | Where-Object {$_.Tag_Name -match "live-desktop"} | Select-Object -First 1
	$version = $tags.tag_name.Split('@')[-1]
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	
	# Get the link to download the file
	$releases = 'https://download.live.ledger.com/'
	$Page = Invoke-WebRequest -Uri $releases
	$url64 = $Page.Links.href | Where-Object { $_ -match "-win-x64\.exe" } | Where-Object {$_ -match $version} | Where-Object {$_ -notmatch "block"}
	if($tags.prerelease -match "true") {
		$date = $tags.published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}

	$Latest = @{ URL64 = $url64; Version = $version }
	return $Latest
}

update -ChecksumFor 64
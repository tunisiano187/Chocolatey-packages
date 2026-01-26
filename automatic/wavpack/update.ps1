import-module chocolatey-AU

$releases = 'https://github.com/dbry/WavPack/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2


function global:au_SearchReplace {
	@{
    "tools/chocolateyInstall.ps1" = @{
      "(^[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
      "(^[$]url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(^[$]checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
      "(^[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
      "(^[$]checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
    }
	}
}

function global:au_AfterUpdate($Package) {
  $Latest.LicenseUrl = (Get-GitHubLicense -OwnerName $Owner -RepositoryName $repo).html_url
  Update-Metadata -key "licenseUrl" -value $Latest.LicenseUrl
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$urls = $tags.assets.browser_download_url | Where-Object {$_ -match "zip$"}
  $url32 = $urls | Where-Object {$_ -match 'x86'} | Where-Object {$_ -notmatch 'winXP'}
  $url64 = $urls | Where-Object {$_ -match 'x64'} | Where-Object {$_ -notmatch 'winXP'}

	[version]$version = $tags.tag_name.Replace('v','').trim()
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	if($tags.prerelease -match "true") {
		$date = $tags.published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update

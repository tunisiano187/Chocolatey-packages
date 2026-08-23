import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://github.com/DuckieTV/Nightlies/releases'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 2
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 1


function global:au_SearchReplace {
	@{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*[$]url(32)?\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*[$]url64\s*=\s*)('.*')"         = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*[$]checksum(32)?\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*[$]checksum64\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*[$]checksumType\s*=\s*)('.*')"  = "`$1'$($Latest.ChecksumType32)'"
    }
	}
}

function global:au_BeforeUpdate($Package) {
  $licenseData = get-githubLicense -OwnerName $Owner -RepositoryName $repo
  $Latest.LicenseUrl = $licenseData.html_url
}

function global:au_AfterUpdate($Package) {
  Update-Metadata -key "licenseUrl" -value $Latest.LicenseUrl
  Update-Metadata -key "releaseNotes" -value $Latest.ReleaseUri
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
  $page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	# The old "match 'tag', skip 1, take 2" heuristic assumed exactly one nav link containing
	# the substring "tag" (e.g. a "Tags" page link) precedes the real per-release "/tag/<name>"
	# links -- but that substring also matches GitHub's own "/tags" link, and how many of those
	# appear before the release list isn't stable across GitHub UI changes. Confirmed live: this
	# picked a non-existent tag and Get-GitHubRelease -Tag threw a 404. Match the real release
	# tag URL shape directly instead of guessing an offset.
	$tag = ($page.Links | Where-Object {$_.href -match "/tag/"} | Select-Object -First 1).href.split('/')[-1]
	if (-not $tag) {
		throw "Could not find a release tag link on $releases"
	}
  $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Tag $tag
	$urls = $tags.assets.browser_download_url | Where-Object {$_ -match ".zip$"}
  $url32 = $urls | Where-Object {$_ -match 'windows-x32'}
  $url64 = $urls | Where-Object {$_ -match 'windows-x64'}
	[version]$version = "$(($tags.tag_name.Split('-') | Select-Object -Last 1) -replace '....(?!$)','$0.')"
  $versioncomplete = $version
  if($tags.prerelease) {
    $versioncomplete = "$($version.ToString())-nightly"
  }

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $versioncomplete; ReleaseUri = $tags.html_url }
	return $Latest
}

update

import-module au

$releases = 'https://github.com/DuckieTV/Nightlies/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2


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
  $Latest.LicenseUrl = $licenseData.html_url
}

function global:au_AfterUpdate($Package) {
  Update-Metadata -key "licenseUrl" -value $Latest.LicenseUrl
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$urls = $tags.assets.browser_download_url | Where-Object {$_ -match ".zip$"}
  $url32 = $urls | Where-Object {$_ -match 'windows-x32'}
  $url64 = $urls | Where-Object {$_ -match 'windows-x64'}
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	[version]$version = "$(($tags.tag_name.Split('-') | Select-Object -Last 1) -replace '....(?!$)','$0.')"
  $versioncomplete = "$($version.ToString())-nightly"

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $versioncomplete; ReleaseUri = $release.latest.ReleaseUrl }
	return $Latest
}

update

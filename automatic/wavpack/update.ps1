import-module au

$releases = 'https://github.com/dbry/WavPack/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2


function global:au_SearchReplace {
	@{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseUri)>"
      "(?i)(^\s*url(32)?\:\s*).*"         = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum(32)?\:\s*).*"    = "`${1}$($Latest.Checksum32)"
      "(?i)(^\s*checksum\s*type\:\s*).*"  = "`${1}$($Latest.ChecksumType32)"
      "(?i)(^\s*url64\s*).*"              = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum64\s*).*"         = "`${1}$($Latest.Checksum64)"
    }
	}
}

function global:au_BeforeUpdate($Package) {
  $licenseData = Get-GithubRepositoryLicense $Owner $repo
  $licenseFile = "$PSScriptRoot\legal\LICENSE.txt"
  if (Test-Path $licenseFile) { Remove-Item -Force $licenseFile }

  Invoke-WebRequest -Uri $licenseData.download_url -UseBasicParsing -OutFile "$licenseFile"
  $Latest.LicenseUrl = $licenseData.html_url

  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_AfterUpdate($Package) {
  $Latest.LicenseUrl = (Get-GitHubLicense -OwnerName $Owner -RepositoryName $repo).html_url
  Update-Metadata -key "licenseUrl" -value $Latest.LicenseUrl
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$urls = $tags.assets.browser_download_url | Where-Object {$_ -match "zip$"}
  $url32 = $urls | Where-Object {$_ -match 'x86'}
  $url64 = $urls | Where-Object {$_ -match 'x64'}

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

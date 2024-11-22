import-module au

$releases = 'https://github.com/Nexus-Mods/Nexus-Mod-Manager/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2


function global:au_SearchReplace {
	@{
		".\legal\VERIFICATION.txt" = @{
			"(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseUri)>"
			"(?i)(^\s*url(32)?\:\s*).*"         = "`${1}<$($Latest.URL32)>"
			"(?i)(^\s*checksum(32)?\:\s*).*"    = "`${1}$($Latest.Checksum32)"
			"(?i)(^\s*checksum\s*type\:\s*).*"  = "`${1}$($Latest.ChecksumType32)"
		  }
	}
}

function global:au_BeforeUpdate($Package) {
	. ..\..\scripts\Get-GithubRepositoryLicense.ps1
	$licenseData = Get-GithubRepositoryLicense $Owner $repo
	$licenseFile = "$PSScriptRoot\legal\LICENSE.txt"
	if (Test-Path $licenseFile) { Remove-Item -Force $licenseFile }

	Invoke-WebRequest -Uri $licenseData.download_url -UseBasicParsing -OutFile "$licenseFile"
	$Latest.LicenseUrl = $licenseData.html_url

	Update-Metadata -key "licenseUrl" -value $Latest.LicenseUrl

	Get-RemoteFiles -Purge -NoSuffix
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$url32 = $tags.assets.browser_download_url | Where-Object {$_ -match ".exe$"} | Select-Object -First 1
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	$version = $tags.tag_name.Replace('v','').Replace('-','.')
	if($tags.prerelease -match "true") {
		$date = $tags.published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}

	$Latest = @{ URL32 = $url32; Version = $version; ReleaseUri = $tags.html_url }
	return $Latest
}

update -ChecksumFor none
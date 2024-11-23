$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/FortAwesome/Font-Awesome/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		'.\legal\VERIFICATION.txt' = @{
			"(?i)(\s+x32:).*"                   = "`${1} $($Latest.URL32)"
			"(?i)(Get-RemoteChecksum).*"        = "`${1} $($Latest.URL32)"
			"(?i)(\s+checksum32:).*"            = "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_BeforeUpdate {
	Get-RemoteFiles -Purge -NoSuffix
  }

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$url32 = $tags.assets.browser_download_url | Where-Object {$_ -match "-desktop.zip$"}

	$File = "tools\$($url32.Split('/')[-1])"
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion -url $url32 -keep
	Move-Item -Path $FileVersion.TempFile -Destination $File
	$version = $tags.tag_name.Replace('v','')
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	. ..\..\scripts\Get-GithubRepositoryLicense.ps1
	Update-Metadata -key "licenseUrl" -value $(Get-GithubRepositoryLicense $Owner $repo).download_url
	if($tags.prerelease -match "true") {
		$date = $tags.published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}

	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $FileVersion.CHECKSUM; ChecksumType32 = $FileVersion.ChecksumType }
	return $Latest
}

update -ChecksumFor none
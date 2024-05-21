$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/hashcat/hashcat/releases/latest'
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
	Invoke-WebRequest -Uri $Latest.URL32 -OutFile "tools/hashcat.7z"
	$Latest.Checksum32 = (Get-FileHash -Path "tools/hashcat.7z" -Algorithm $env:ChocolateyChecksumType)
	$Latest.ChecksumType32 = $env:ChocolateyChecksumType
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$url32 = $tags.assets.browser_download_url | Where-Object {$_ -match ".7z$"}
	$version = (get-version $tags.name).Version
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	if($tags.prerelease -match "true") {
		$date = $tags.published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
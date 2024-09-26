$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/ukdtom/WebTools.bundle/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.checksumType32)'"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo | Select-Object -First 1
	$url32 = $tags.assets.browser_download_url | Where-Object {$_ -match ".zip$"}
	Update-Metadata -key "releaseNotes" -value $tags.body
	$version = $tags.tag_name.Replace('v','')
	if($tags.prerelease -match "true" -and $version.ToString() -notmatch 'beta') {
		$date = $tags.published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	} elseif ($version.ToString() -match 'beta') {
		$version="$($version.Split('a')[0])a$($version.Split('a')[1].replace('.',''))"
	}

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
